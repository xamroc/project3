class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.string :name
      t.string :category
      t.text   :description
      t.string :photos
      t.belongs_to :user, index: true
      t.boolean :availability, default: false

      t.timestamps
    end
  end
end
