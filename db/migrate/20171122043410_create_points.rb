class CreatePoints < ActiveRecord::Migration[5.0]
  def change
    create_table :points do |t|
      t.references :user, foreign_key: true
      t.integer :number_of_points

      t.timestamps
    end
  end
end
