object @user

attributes :id, :email, :password, :password_confirmation, :salt, :fish
attribute :name, :description, :facebook, :mobile_number if current_user
