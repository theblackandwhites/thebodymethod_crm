class CreateQualifications < ActiveRecord::Migration[5.0]
  def change
    create_table :qualifications do |t|
      t.string :title
      t.references :instructor, foreign_key: true

      t.timestamps
    end
  end
end
