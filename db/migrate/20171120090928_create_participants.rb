class CreateParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :participants do |t|
      t.references :bookable, foreign_key: true
      t.references :user, foreign_key: true
      t.references :charge, foreign_key: true
      t.boolean :checked_in
      t.string :payment_method
      t.string :payment_status
      t.boolean :cancelled
      t.text :cancellation_reason

      t.timestamps
    end
  end
end
