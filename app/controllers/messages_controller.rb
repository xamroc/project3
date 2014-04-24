class MessagesController < ApplicationController

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

