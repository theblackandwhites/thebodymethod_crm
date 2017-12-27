class AddStartTimeToBookables < ActiveRecord::Migration[5.0]
  def change
    add_column :bookables, :start_time, :datetime
  end
end
