class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :description
      t.integer :price
      t.date :date

      t.timestamps null: false
    end
  end
end
