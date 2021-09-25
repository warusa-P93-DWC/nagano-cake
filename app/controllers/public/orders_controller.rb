class Public::OrdersController < ApplicationController
    def index
        #最新の注文から並べるために.reverse_orderを使用している
        @orders = current_customer.orders.page(params[:page]).per(8).reverse_order
    end
    
    
    def complete
      cart_items = current_customer.cart_items
      cart_items.destroy_all
    end

    
    def new
        @order = Order.new
        @address = current_customer.address
        # @shipping_address_new = ShippingAddress.new
        # @shipping_addresses = current_customer.shipping_addresses
    end
    
    
    #newページから情報を取得して、confirmページ上に情報を書き出すための記述
    def confirm
        @cart_products = current_customer.carts
        @order = Order.new(order_params)
        # @order.shipping_fee = 800
        @order.payment_method = params[:order][:payment_method]
        
        #ラジオボタンで選択した時の取得する情報の条件分岐、enumではなくnew.html.erbで0,1,2を振り分けている
        if params[:order][:address_num] == "0"
            @order.postcode = current_customer.postcode
            @order.address = current_customer.address
            @order.name = current_customer.last_name + current_customer.first_name
        elsif params[:order][:address_num] == "1"
            #f.selectのaddress_boxの中の/:id の番号を取得する
            @shipping_address = ShippingAddress.find(params[:order][:address_box])
            @order.postcode = @shipping_address.postcode
            # @order.address = @shipping_address.address
            @order.name = @shipping_address.name
            
        elsif params[:order][:address_num] == "2"
            @order.postcode = params[:order][:postcode]
            @order.address = params[:order][:address]
            @order.name = params[:order][:name]
        end
        
    end
    
    def show
        @order = Order.find(params[:id])
        @order_products = @order.order_products
    end
    
    #confirmページで注文を確定するを押した後の動作を記述してる
    def create
        #order_paramsで取得できる情報の保存
        order = Order.new(order_params)
        order.status = 0
        order.customer_id = current_customer.id
        order.save
        
        #商品情報の保存
        cart_products = current_customer.cart_products
        cart_products.each do |item|
            order_product = OrderProduct.new
            order_product.order_id = order.id
            order_product.product_id = item.product.id
            order_product.amount = item.amount
            order_product.price = item.sub_price
            order_product.status = 0
            order_product.save
        end

        current_customer.cart_products.destroy_all
        
        
        unless Customer.where(id: order.customer_id).where(postcode: order.postcode).where(address: order.address) || ShippingAddress.where(customer_id: order.customer_id).where(name: order.name).where(postcode: order.postcode).where(address: order.address).exits?                                       
            shipping_address = ShippingAddress.new
            shipping_address.customer_id = order.customer_id
            shipping_address.name = order.name
            shipping_address.postcode = order.postcode
            shipping_address.address = order.address
            shipping_address.save
        end
        redirect_to orders_thanks_path
    end
    
    private
    
    def order_params
        params.require(:order).permit(:payment_method, :postcode, :address, :name, :bill, :shipping_fee, :status, :customer_id)
    end
    
end