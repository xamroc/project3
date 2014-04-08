class AddNewFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :description, :string
    add_column :users, :photo, :string
    add_column :users, :facebook, :string
    add_column :users, :mobile_number, :string
  end
end
