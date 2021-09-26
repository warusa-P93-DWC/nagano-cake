class Public::HomesController < ApplicationController
  def top
  end

  def about
  end
  
  def unsubscribe
    @customer = Customer.find_by(params[:id])
  end

  def withdraw
    @customer = Customer.find_by(params[:id])
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end
  
end
