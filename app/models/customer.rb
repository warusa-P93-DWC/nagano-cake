class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :carts
  
  def active_for_authentication?
    super && (self.is_deleted == false)
  end
  
  validates :postal_code, length: { maximum: 255 }
  validates :telephone_number, length: { maximum: 50 }
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
