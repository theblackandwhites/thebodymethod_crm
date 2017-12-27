class CreateBookables < ActiveRecord::Migration[5.0]
  def change
    create_table :bookables do |t|
      t.date :date_start
      t.string :time_start
      t.string :time_start_unit
      t.string :time_finish
      t.string :time_finish_unit
      t.references :bookable_type, foreign_key: true
      t.references :location, foreign_key: true
      t.references :instructor, foreign_key: true
      t.decimal :price
      t.boolean :pay_cash
      t.boolean :pay_online
      t.boolean :pay_points

      t.timestamps
    end
  end
end
