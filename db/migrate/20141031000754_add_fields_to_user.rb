class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :handle, :string, limit: 80, null: false, default: ''
    add_column :users, :profile_text, :string, limit: 512

    add_index :users, :handle
  end
end
