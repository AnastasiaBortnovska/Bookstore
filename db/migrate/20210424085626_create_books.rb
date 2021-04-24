class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :name, null: false
      t.decimal :price, precision: 12, scale: 2
      t.text :description
      t.integer :publication_year
      t.float :height
      t.float :width
      t.float :depth
      t.string :material
      t.integer :quantity
      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
  end
end
