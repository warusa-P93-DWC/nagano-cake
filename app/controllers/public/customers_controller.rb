class Public::CustomersController < ApplicationController
    
    def update
    end
    
    def edit
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
end
