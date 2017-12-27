class AddRecurringToBookable < ActiveRecord::Migration[5.0]
  def change
    add_column :bookables, :recurring, :text
  end
end
