class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :last_name
      t.string :first_name
      t.string :kana_last_name
      t.string :kana_fast_name
      t.string :email
      t.string :encrypted_password
      t.string :postal_code
      t.string :telephone_number
      t.string :address
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
