class CreateBatches < ActiveRecord::Migration[6.1]
  def change
    create_table :batches do |t|
      t.date :expiry
      t.integer :quantity
      t.references :user_stock, null: false, foreign_key: true

      t.timestamps
    end
  end
end
