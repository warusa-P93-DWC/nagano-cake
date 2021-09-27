class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
    @item_counts = Item.all
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    # @cart_item = Cart.find(params[:id])
    @genres = Genre.all
    @cart_items = Cart.new
    @cart = Cart.all
  end

  def search
    @genres = Genre.all
    if params[:name].present?
      @items = Item.where('name LIKE ?', "%#{params[:name]}%")
    else
      @items = Item.none
    end
  end


end
