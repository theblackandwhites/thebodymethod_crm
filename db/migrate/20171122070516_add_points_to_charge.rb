class AddPointsToCharge < ActiveRecord::Migration[5.0]
  def change
    add_column :charges, :points, :boolean
    add_column :charges, :points_paid_with, :integer
    add_column :charges, :left_to_pay, :decimal
    add_column :charges, :left_to_pay_method, :string
  end
end
