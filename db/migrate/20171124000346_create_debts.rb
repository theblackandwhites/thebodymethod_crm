class CreateDebts < ActiveRecord::Migration[5.0]
  def change
    create_table :debts do |t|
      t.references :user, foreign_key: true
      t.references :bookable, foreign_key: true
      t.references :participant, foreign_key: true
      t.decimal :amount

      t.timestamps
    end
  end
end
