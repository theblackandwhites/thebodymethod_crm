class AddRestrictionsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :pay_online_only, :boolean
  end
end
