class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :number, unique: true
      t.integer :status, default: 0
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
