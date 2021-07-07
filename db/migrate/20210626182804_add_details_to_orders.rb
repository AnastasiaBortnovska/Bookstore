class AddDetailsToOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :delivery, foreign_key: true
    add_reference :orders, :credit_card, foreign_key: true
    add_column :orders, :use_billing, :boolean, default: false
  end
end
