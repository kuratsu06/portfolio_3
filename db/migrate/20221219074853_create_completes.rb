class CreateCompletes < ActiveRecord::Migration[7.0]
  def change
    create_table :completes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.date :done, null: false
      t.text :memo
      t.string :image
      t.integer :again, null: false, default: 0
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
