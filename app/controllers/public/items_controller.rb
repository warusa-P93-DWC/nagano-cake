class Public::ItemsController < ApplicationController
  def index
     @items = Item.all
     @items = Item.page(params[:page]).reverse_order
     @genres = Genre.all

    
  end

  def show
    @item = Item.find(params[:id])
    @cart= Cart.new
    @genres = Genre.all
  end


end
