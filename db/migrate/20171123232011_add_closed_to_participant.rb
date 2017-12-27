class AddClosedToParticipant < ActiveRecord::Migration[5.0]
  def change
    add_column :participants, :closed, :boolean
  end
end
