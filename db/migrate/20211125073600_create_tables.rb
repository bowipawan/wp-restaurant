class CreateTables < ActiveRecord::Migration[6.1]
  def change
    create_table :tables do |t|
      t.integer :customer_cap
      t.integer :table_number
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
