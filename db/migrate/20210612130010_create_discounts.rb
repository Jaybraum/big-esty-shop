class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.integer :percentage_discount
      t.integer :quantity_threshold
      t.timestamps
    end
  end
end
