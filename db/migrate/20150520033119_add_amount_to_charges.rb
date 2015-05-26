class AddAmountToCharges < ActiveRecord::Migration
  def change
    add_column :charges, :amount, :decimal
  end
end
