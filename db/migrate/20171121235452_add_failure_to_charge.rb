class AddFailureToCharge < ActiveRecord::Migration[5.0]
  def change
    add_column :charges, :failure_code, :string
    add_column :charges, :failure_message, :string
    add_column :charges, :status, :string
  end
end
