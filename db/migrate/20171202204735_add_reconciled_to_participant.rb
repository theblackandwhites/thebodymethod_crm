class AddReconciledToParticipant < ActiveRecord::Migration[5.0]
  def change
    add_column :participants, :reconciled, :boolean
  end
end
