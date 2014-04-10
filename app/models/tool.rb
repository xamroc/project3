class Tool < ActiveRecord::Base

  belongs_to :user

  validates :name, :category, :description, presence: true

  def toggle_availability
    self.availability = !self.availability
  end

end
