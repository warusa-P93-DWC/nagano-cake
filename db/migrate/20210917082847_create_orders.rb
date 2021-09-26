class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :postage
      t.string :address
      t.string :postal_code
      t.integer :total_payment
      t.string :name
      t.integer :status
      t.integer :payment_method

      t.timestamps
    end
  end
end
