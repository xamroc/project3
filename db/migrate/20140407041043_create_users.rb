class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :password_confirmation
      t.string :salt
      t.string :fish
      t.string :first_name
      t.string :last_name
      t.string :description
      t.string :photo
      t.string :facebook
      t.string :mobile_number
      t.string :street_address2
      t.string :street_address1
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
