class CreateOrderDeliveries < ActiveRecord::Migration[6.1]
  def change
    create_table :order_deliveries do |t|
      t.references :order, foreign_key: true, index: true
      t.references :delivery, foreign_key: true, index: true

      t.timestamps
    end
  end
end
