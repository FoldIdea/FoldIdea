class CreateBaseUnits < ActiveRecord::Migration
  def change
    create_table :base_units do |t|
      t.string :name, limit: 100, null: false
      t.integer :base_width, null: false
      t.integer :base_length, null: false

      t.timestamps
    end
  end
end
