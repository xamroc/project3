object false

child @messages, object_root: false do
  attributes :subject, :body, :sender_id, :recipient_id, :read_at, :sender_deleted, :recipient_deleted

  node :links do |message|
    {
      recipient: message.recipient(message),
      sender: message.sender(message)
    }
  end

end