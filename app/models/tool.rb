class Tool < ActiveRecord::Base

  belongs_to :user

  validates :name, :category, :description, presence: true

end
