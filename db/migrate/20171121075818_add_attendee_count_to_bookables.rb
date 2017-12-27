class AddAttendeeCountToBookables < ActiveRecord::Migration[5.0]
  def change
    add_column :bookables, :attendee_count, :integer
  end
end
