class RemovePriceTagFromTools < ActiveRecord::Migration
  def change
    remove_column :tools, :price, :string
    remove_column :tools, :tag, :string
  end
end
