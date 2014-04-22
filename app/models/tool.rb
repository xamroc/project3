class Tool < ActiveRecord::Base

  belongs_to :owner, inverse_of: :tools_owned, foreign_key: "user_id", class_name: "User"

  has_many :transactions
  has_many :users, through: :transactions

  validates :name, :category, :description, presence: true

  def toggle_availability
    self.availability = !self.availability
  end

end
