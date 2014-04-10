class Tool < ActiveRecord::Base

  belongs_to :user

  has_many :transactions
  has_many :users, through: :transactions

  validates :name, :category, :description, presence: true

  def toggle_availability
    self.availability = !self.availability
  end

end
