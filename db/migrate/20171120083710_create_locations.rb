class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :zipcode
      t.string :state
      t.string :country
      t.string :phone_number
      t.string :email_address

      t.timestamps
    end
  end
end
