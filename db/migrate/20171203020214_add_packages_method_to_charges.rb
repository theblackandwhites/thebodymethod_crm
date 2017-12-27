class AddPackagesMethodToCharges < ActiveRecord::Migration[5.0]
  def change
    add_column :charges, :packages_payment, :boolean
  end
end
