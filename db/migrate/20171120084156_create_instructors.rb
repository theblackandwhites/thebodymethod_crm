class CreateInstructors < ActiveRecord::Migration[5.0]
  def change
    create_table :instructors do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.date :dob
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :country
      t.string :phone
      t.string :phone2
      t.string :email
      t.text :bio

      t.timestamps
    end
  end
end
