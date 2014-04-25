class Message < ActiveRecord::Base

  # attr_accessible :subject, :body, :sender_id, :recipient_id, :read_at, :sender_deleted, :recipient_deleted
  validates_presence_of :subject, :message => "Please enter message title"

  belongs_to :sender, inverse_of: :sent_messages, :class_name => 'User', :foreign_key => 'sender_id'
  belongs_to :recipient, inverse_of: :received_messages, :class_name => 'User', :foreign_key => 'recipient_id'

  def mark_message_deleted(id, user_id)
    self.sender_deleted = true if self.sender_id == user_id and self.id=id
    self.recipient_deleted = true if self.recipient_id == user.id and self.id=id
    self.sender_deleted && self.recipient_deleted ? self.destroy : save!
  end

  def self.readingmessage(id, reader)
    message = find(id, :conditions => ["sender_id = ? OR recipient_id = ?", reader, reader])
    if message.read_at.nil? && (message.recipient.user_id==reader)
      message.read_at = Time.now
      message.save!
    end
    message
  end

  def read?
    self.read_at.nil? ? false : true
  end

end