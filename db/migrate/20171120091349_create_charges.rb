class CreateCharges < ActiveRecord::Migration[5.0]
  def change
    create_table :charges do |t|
      t.references :user, foreign_key: true
      t.references :bookable, foreign_key: true
      t.string :stripe_id
      t.string :amount
      t.string :card_brand
      t.string :card_last4
      t.string :card_exp_month
      t.string :card_exp_year

      t.timestamps
    end
  end
end
