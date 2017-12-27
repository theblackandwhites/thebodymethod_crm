class CreatePackages < ActiveRecord::Migration[5.0]
  def change
    create_table :packages do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.boolean :subscription
      t.integer :subscription_interval_count
      t.string :subscription_interval
      t.string :stripe_subscription_id

      t.timestamps
    end
  end
end
