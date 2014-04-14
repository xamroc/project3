collection @users, root: :users

attributes :name, :description, :photo, :city, :country, :email
attribute :name, :city, :country, :description, :facebook, :mobile_number, :email if current_user

node :href do |user|
  user_url(user)
end