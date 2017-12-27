class AddReasonsToCharges < ActiveRecord::Migration[5.0]
  def change
    add_column :charges, :online_payment, :boolean
    add_column :charges, :points_cash_payment, :boolean
    add_column :charges, :points_online_payment, :boolean
    add_column :charges, :cash_payment, :boolean
    add_column :charges, :eftpos_payment, :boolean
    add_column :charges, :debt_payment, :boolean
  end
end
