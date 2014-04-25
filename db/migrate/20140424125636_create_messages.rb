class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string      :sender_id
      t.string      :recipient_id
      t.boolean     :sender_deleted, :recipient_deleted
      t.string      :subject, :null => false
      t.text        :body
      t.datetime    :read_at
      t.string      :container, :default => "draft"

      t.timestamps
    end
  end
end
