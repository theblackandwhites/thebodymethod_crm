class CreateWaitingLists < ActiveRecord::Migration[5.0]
  def change
    create_table :waiting_lists do |t|
      t.references :user, foreign_key: true
      t.references :bookable, foreign_key: true

      t.timestamps
    end
  end
end
