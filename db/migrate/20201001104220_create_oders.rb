class CreateOders < ActiveRecord::Migration[5.2]
  def change
    create_table :oders do |t|
      t.integer :customer_id
      t.string :addressee
      t.string :post_code
      t.string :address
      t.integer :how_to_pay,default: 0,null: false
      t.integer :deliver_fee
      t.integer :order_status,default: 0,null: false
      t.integer :total_payment

      t.timestamps
    end
  end
end
