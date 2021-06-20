class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.integer :score, default: 0
      t.string :state, default: 'unprocessed'
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
