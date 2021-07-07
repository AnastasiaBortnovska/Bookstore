class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.integer :score, default: 0
      t.integer :state, default: 0
      t.references :user, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true

      t.timestamps
    end
  end
end
