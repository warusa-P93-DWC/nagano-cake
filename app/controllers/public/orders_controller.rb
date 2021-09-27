class Public::OrdersController < ApplicationController
  def index
    @orders = Order.where(customer_id:current_customer)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_dates
  end

  def new
    # @ship_addresses = current_customer(addresse_id)
    @ship_address = Address.new
    @order = Order.new
  end

  def confirm
    @orders = current_customer.orders
    # @total_price = calculate(current_customer)
    @cart_items = current_customer.carts
    # 現在の住所を使う場合
    if params[:address] == 'now'
      @order = Order.new(
        customer_id: @customer.id,
        postal_code: @customer.postal_code,
        address: @customer.address,
        name: @customer.last_name + @customer.first_name,
        payment_method: params[:order][:payment_method]
      )
    # 配送先登録した住所を使う場合
    elsif params[:address] == 'select'
      address =  Address.find_by(id: params[:select]) # params[:select]は選択した住所のid
      @order = Order.new(
        customer_id: @customer.id,
        postal_code: address.postal_code,
        address: address.address,
        name: address.name,
        payment_method: params[:order][:payment_method]
      )
    # 新しく住所を追加する場合
    elsif params[:address] == 'new'
      @order = Order.new(order_params)
    else
      @order = Order.new(order_params)
    end
    
    
    @total_price = 0
    @cart_items.each do |cart_item|
    @total_price += cart_item.quantity * cart_item.item.price
    
    # if @order.invalid?(:confirm)
      # render :new
    # end
    end 
  end  
  
  
  

  def create
    session[:payment] = params[:payment]
    if params[:select] == "select_address"
      session[:address] = params[:address]
    elsif params[:select] == "my_address"
      session[:address] = "〒" + current_customer.post_code+current_customer.address+current_customer.l_name+current_customer.f_name
    end
    if session[:address].present? && session[:payment].present?
      redirect_to orders_confirm_path
    else
      flash[:order_new] = "支払い方法と配送先を選択して下さい"
      redirect_to new_order_path
    end

  end

  # 情報入力画面にて新規配送先の登録
  def create_ship_address
    @ship_address = Address.new(ship_address_params)
    @ship_address.customer_id = current_customer.id
    @ship_address.save
    redirect_to new_order_path
  end


  def create_order
    # オーダーの保存
    @order = Order.new
    @order.customer_id = current_customer.id
    @order.address = session[:address]
    @order.payment = session[:payment_method]
    @order.total_price = calculate(current_customer)
    @order.order_status = 0
    @order.save
    # saveができた段階でOrderモデルにorder_idが入る

    # オーダー商品ごとの詳細の保存
    current_customer.carts.each do |cart|
      @order_detail = OrderDate.new
      @order_detail.order_id = @order.id
      @order_detail.item_name = cart.item.name
      @order_detail.item_price = cart.item.price
      @order_detail.quantity = cart.quantity
      @order_detail.item_status = 0
      @order_detail.save
    end
    
    current_customer.carts.destroy_all
    session.delete(:address)
    session.delete(:payment)
    # redirect_to thanks_path
  end

  private
   def ship_address_params
     params.require(:address).permit(:customer_id,:last_name, :first_name, :postal_code, :address)
   end
   def order_params
     params.require(:order).permit(:customer_id, :address, :payment_method, :total_payment, :order_status, :name, :postal_code)
   end

   # 商品合計（税込）の計算
  # def calculate(user)
  #   total_price = 0
  #   user.carts.each do |cart_item|
  #   total_price += cart_item.quantity * cart_item.item.price
  #   end
  #   return (total_price * 1.1).floor
  # end
end 