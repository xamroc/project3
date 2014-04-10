class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :password_confirmation
      t.string :salt
      t.string :fish
      t.string :name
      t.string :description
      t.string :photo
      t.string :facebook
      t.string :mobile_number

      t.timestamps
    end
  end
end
