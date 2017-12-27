class AddRegularToWalkin < ActiveRecord::Migration[5.0]
  def change
    add_column :walkins, :become_regular, :boolean
  end
end
