class Public::CustomersController < ApplicationController
    
    def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to edit_public_customer_path
    end
    
    def edit
        @customer = current_customer
    end
    
    def show
        @customer = current_customer
    end

    def hide
        @customer = Customer.find(params[:id])
        #is_deletedカラムにフラグを立てる(defaultはfalse)
        @customer.update(is_deleted: true)
        #ログアウトさせる
        reset_session
        flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
        redirect_to root_path
    end
    private
    def customer_params
        params.require(:customer).permit(:last_name,:first_name,:kana_last_name,:kana_first_name,:email,:telephone_number,:postal_code,:address)
    end
end
