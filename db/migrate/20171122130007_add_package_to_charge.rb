class AddPackageToCharge < ActiveRecord::Migration[5.0]
  def change
    add_reference :charges, :package, foreign_key: true
  end
end
