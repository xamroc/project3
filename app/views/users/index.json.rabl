collection @users, root: :users

attributes :id, :email, :password, :password_confirmation, :salt, :fish

node :href do |user|
  user_url(user)
end