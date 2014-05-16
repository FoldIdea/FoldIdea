class CreateTrays < ActiveRecord::Migration
  def change
    create_table :trays do |t|
      t.references :base_unit, index: true
      t.integer :files, null: false
      t.integer :ranks, null: false
      t.float :gap_percent, null: false, default: 0.05

      t.timestamps
    end
  end
end
