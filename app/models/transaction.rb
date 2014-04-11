class Transaction < ActiveRecord::Base

  belongs_to :user
  belongs_to :tool

  validates_associated :user, :tool
  validates_presence_of :user, :tool

end
