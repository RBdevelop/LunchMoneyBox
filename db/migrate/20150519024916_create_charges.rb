class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.belongs_to :parent, index: true

      t.timestamps null: false
    end
    add_foreign_key :charges, :parents
  end
end
