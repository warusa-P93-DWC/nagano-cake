class Public::AddressesController < ApplicationController
  def index
    @addresses = Address.all
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
   @address = Address.new(address_params)
   if @address.save
    redirect_to public_addresses_path
   else
    redirect_to public_addresses_path
   end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to public_addresses_path
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to edit_public_customer_path
  end
end
  private
    def address_params
        params.require(:address).permit(:postal_code, :address, :name)
    end
