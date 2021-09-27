class Item < ApplicationRecord
  belongs_to :genre
  has_many :carts
  has_many :orders
  attachment :image 
end
