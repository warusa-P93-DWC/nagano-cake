class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  has_many :order_details, dependent: :destroy
end
