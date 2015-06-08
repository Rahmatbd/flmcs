class CreateFlexiloads < ActiveRecord::Migration
  def change
    create_table :flexiloads do |t|
      t.string :phone
      t.integer :type
      t.integer :amount
      t.string :flmcs_order_id
      t.string :flmcs_transaction_id
      t.string :status

      t.timestamps null: false
    end
  end
end
