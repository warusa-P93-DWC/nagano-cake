class Item < ApplicationRecord
  belongs_to :genre
  has_many :carts
  attachment :image 
end
