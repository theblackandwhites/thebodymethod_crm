class CreateUserPackages < ActiveRecord::Migration[5.0]
  def change
    create_table :user_packages do |t|
      t.references :user, foreign_key: true
      t.references :package, foreign_key: true

      t.timestamps
    end
  end
end
