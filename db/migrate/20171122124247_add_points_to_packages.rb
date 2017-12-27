class AddPointsToPackages < ActiveRecord::Migration[5.0]
  def change
    add_column :packages, :number_of_points, :integer
  end
end
