class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :title, null: false
      t.text :memo
      t.string :image
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
