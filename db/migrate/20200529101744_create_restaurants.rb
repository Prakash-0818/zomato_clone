# frozen_string_literal: true

class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.text :address, null: false
      t.text :phone_no, null: false

      t.timestamps
    end
  end
end
