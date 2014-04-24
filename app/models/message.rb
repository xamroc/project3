class Message < ActiveRecord::Base

  attr_accessible :subject, :body, :sender_id, :recipient_id, :read_at, :sender_deleted, :recipient_deleted
  validates_presence_of :subject, :message => "Please enter message title"

  belongs_to :sender, :class_name => 'User', :primary_key => 'user_id', :foreign_key => 'sender_id'
  belongs_to :recipient, :class_name => 'User', :primary_key => 'user_id', :foreign_key => 'recipient_id'

  def mark_message_deleted(id, user_id)
    self.sender_deleted = true
      if self.sender_id == user_id and <span class="skimlinks-unlinked">self.id=id</span>
    self.recipient_deleted = true
      if self.recipient_id == user.id and <span class="skimlinks-unlinked">self.id=id</span>
    self.sender_deleted && self.recipient_deleted ? self.destroy : save!
  end

  def self.readingmessage(id, reader)
    message = find(id, :conditions => ["sender_id = ? OR recipient_id = ?", reader, reader])
    if <span class="skimlinks-unlinked">message.read_at.nil</span>? && (message.recipient.user_id==reader)
      message.read_at = <span class="skimlinks-unlinked">Time.now</span>
      <span class="skimlinks-unlinked">message.save</span>!
    end
    message
  end

  def read?
    <span class="skimlinks-unlinked">self.read_at.nil</span>? ? false : true
  end

end