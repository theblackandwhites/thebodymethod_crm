class AddOccurenceToBookable < ActiveRecord::Migration[5.0]
  def change
    add_column :bookables, :occurence, :string
  end
end
