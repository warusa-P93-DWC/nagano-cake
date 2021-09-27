class Item < ApplicationRecord
  belongs_to :genre
  has_many :carts
  has_many :order_de
  attachment :image 
end
