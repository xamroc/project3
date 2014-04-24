object false

child @users, object_root: false do

  attributes :id, :name, :description, :avatar, :city, :country, :email
  attribute :name, :city, :country, :description, :facebook, :mobile_number, :email if current_user

  node :href do |user|
    user_url(user)
  end

  node :links do |user|
    {
      tools: user.tools_owned,
      transactions: user_transactions_url(user)
    }
  end

end