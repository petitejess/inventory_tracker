class CreateUserStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :user_stocks do |t|
      t.string :name
      t.binary :image
      t.references :category, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
