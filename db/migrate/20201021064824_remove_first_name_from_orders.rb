class RemoveFirstNameFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :first_name, :string
  end
end
