collection @users, root: :users

attributes :id, :email, :password, :password_confirmation, :salt, :fish, :photo
attribute :name, :description, :facebook, :mobile_number if current_user

node :href do |user|
  user_url(user)
end