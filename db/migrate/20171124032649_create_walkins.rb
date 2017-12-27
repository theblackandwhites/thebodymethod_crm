class CreateWalkins < ActiveRecord::Migration[5.0]
  def change
    create_table :walkins do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end