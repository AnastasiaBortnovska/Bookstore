class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.string :code, unique: true
      t.integer :discount_percent, default: 10
      t.boolean :active, default: true
      t.references :order, foreign_key: true, index: true

      t.timestamps
    end
  end
end
