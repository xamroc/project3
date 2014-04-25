'require pry'
class MessagesController < ApplicationController

  before_filter :set_user

  def index
    @user = current_user
    message = Message.find(params[:id])
    message.sender = @user
    # @user = current_user
    if params[:mailbox] == "sent"
      @messages= @user.sent_messages
    elsif params{:mailbox} == "inbox"
      @messages = @user.received_messages
    end
    # @messages = Message.all
  end

  def new
    @message = Message.new
    if params[:reply_to]
      @reply_to = User.find_by_user_id(params[:reply_to])
      unless @reply_to.nil?
        @message.recepient_id = @reply_to.user_id
      end
    end
  end

  def create
    @message = Message.new(params[:message])
    @message.sender_id = @user.user_id
    if @message.save
      flash[:notice] = "Message has been sent"
      redirect_to user_messages_path(current_user, :mailbox=>:inbox)
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
    params.require(:message).permit(:subject, :body, :sender_id, :recipient_id, :read_at, :sender_deleted, :recipient_deleted)
  end

  def set_user
    @user = current_user
  end

end

