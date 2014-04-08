class AddNewFieldsToTool < ActiveRecord::Migration
  def change
    add_column :tools, :availability, :string
  end
end
