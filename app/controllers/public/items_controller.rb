class Public::ItemsController < ApplicationController
  def index
     @items = Item.all
     @items = Item.page(params[:page]).per(10)
  end

  def show
  end

  def edit
    @item = Item.find(params[:id])
  end
end
