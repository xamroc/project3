class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.string :name
      t.string :category
      t.string :description
      t.string :photos
      t.belongs_to :user
      t.boolean :availability

      t.timestamps
    end
  end
end
