class CreateOrderBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :order_books do |t|
      t.integer :quantity, default: 0
      t.references :order, foreign_key: true, index: true
      t.references :book, foreign_key: true, index: true

      t.timestamps
    end
  end
end
