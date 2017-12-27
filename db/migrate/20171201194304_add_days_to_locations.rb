class AddDaysToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :time_monday, :string
    add_column :locations, :time_tuesday, :string
    add_column :locations, :time_wednesday, :string
    add_column :locations, :time_thursday, :string
    add_column :locations, :time_friday, :string
    add_column :locations, :time_saturday, :string
    add_column :locations, :time_sunday, :string
    add_column :locations, :description, :text
  end
end
