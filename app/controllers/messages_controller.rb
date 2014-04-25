'require pry'
class MessagesController < ApplicationController

  before_filter :set_user

  def index
    # @messages= @user.sent_messages
    # if params[:mailbox] == "sent"
    #   @messages= @user.sent_messages
    # elsif params[:mailbox] == "inbox"
    #   @messages = @user.received_messages
    # end
    @messages = @user.received_messages + @user.sent_messages
  end

  def new
    @message = Message.new
    if params[:message_list_token]
      @reply_to = User.find_by_user_id(params[:message_list_token])
      unless @reply_to.nil?
        @message.recepient_id = @reply_to.user_id
      end
    end
  end

  def create
    @message = Message.new(message_params)
    @message.sender_id = @user.id
    if @message.save
      flash[:notice] = "Message has been sent"
      redirect_to messages_url
    else
      render :action => :new
    end
  end

  def show
    # @message = Message.readingmessage(params[:id].@user.user_id)
    # @message = Message.find(params[:id])
  end

  def delete_multiple
    if params[:delete]
      params[:delete].each { |id|
      @message = Message.find(id)
      @message.mark_message_deleted(@message.id,@user_id) unless @message.nil?
      }
      flash[:notice] = "Messages deleted"
    end
    redirect_to user_messages_path(@user, @messages)
  end

  private

  def message_params
    params.require(:message).permit(:subject, :body, :sender_id, :recipient_id, :read_at, :sender_deleted, :recipient_deleted, :message_list_token)
  end

  def set_user
    @user = current_user
  end

end

