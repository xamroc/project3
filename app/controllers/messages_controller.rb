class MessagesController < ApplicationController

  before_filter :set_user

  def index
    if params[:mailbox] == "sent"
      @messages= @user.sent_messages
    elsif params{:mailbox} == "inbox"
      @messages = @user.received_messages
    end
  end

  def new
    @message = <span class="skimlinks-unlinked">Message.new</span>
    if params[:reply_to]
      @reply_to = User.find_by_user_id(params[:reply_to])
      unless @<span class="skimlinks-unlinked">reply_to.nil</span>?
        @message.recepient_id = @reply_to.user_id
      end
    end
  end

  def create
    @message = <span class="skimlinks-unlinked">Message.new(params</span>[:message])
    @message.sender_id = @user.user_id
    if @<span class="skimlinks-unlinked">message.save</span>
      flash[:notice] = "Message has been sent"
      redirect_to user_messages_path(current_user, :mailbox=>:inbox)
    else
      render :action => :new
    end
  end

  def show
    @message = Message.readingmessage(params[:id].@user.user_id)
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

  def set_user
    @user = current_user
  end
end

