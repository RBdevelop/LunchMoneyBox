class AddStripeIdToParent < ActiveRecord::Migration
  def change
    add_column :parents, :stripe_id, :string
  end
end
