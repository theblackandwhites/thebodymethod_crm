class AddReconciledToBookable < ActiveRecord::Migration[5.0]
  def change
    add_column :bookables, :reconciled, :boolean
  end
end
