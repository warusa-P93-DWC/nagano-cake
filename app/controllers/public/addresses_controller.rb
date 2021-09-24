class Public::AddressesController < ApplicationController
  def index
    @addresses = Address.all
    @address = Address.new
  end

  def edit
  end

  def create
   @address = Address.new(address_params)
   if @address.save
    redirect_to public_addresses_path
   else
    render 'new'
   end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to public_addresses_path
  end

  def update
  end
end
  private
    def address_params
        params.require(:address).permit(:postal_code, :address, :name)
    end
