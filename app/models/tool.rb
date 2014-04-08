class Tool < ActiveRecord::Base

  validates :name, :category, :description, presence: true

end
