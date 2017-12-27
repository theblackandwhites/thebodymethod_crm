class AddFieldsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :address_city, :string
    add_column :users, :address_state, :string
    add_column :users, :address_zipcode, :string
  end
end
