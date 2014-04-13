object @user

attributes :first_name, :description, :photo, :city, :country
attribute :first_name, :city, :country, :description, :facebook, :mobile_number, :email if current_user
