class CreateEnquries < ActiveRecord::Migration[5.0]
  def change
    create_table :enquries do |t|
      t.string :full_name
      t.string :email
      t.string :phone
      t.text :message

      t.timestamps
    end
  end
end
