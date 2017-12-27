class AddBookableTypeToCharges < ActiveRecord::Migration[5.0]
  def change
    add_reference :charges, :bookable_type, foreign_key: true
  end
end
