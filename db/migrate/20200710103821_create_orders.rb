class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.text :address
      t.references :cart, null: false, foreign_key: true

      t.timestamps
    end
  end
end