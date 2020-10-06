class AddDefaultToOrders < ActiveRecord::Migration[5.2]
  def change
  	change_column_default :orders, :how_to_pay, 0
  	change_column_default :orders, :order_status, 0

  	change_column_null :orders, :how_to_pay, false
  	change_column_null :orders, :order_status, false
  end
end
