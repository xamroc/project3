class ConversationsController < ApplicationController

  respond_to :json
  before_action :is_authenticated?, only: [:new, :destroy]
  before_action :set_transaction, only: [:destroy]
  before_action :get_parent

  def index
    @conversations = if params[:id]
      conversation.where("id in (?) #{@parent_clause}", params[:id].split(','))
    else
      @parent ? @parent.conversation : Conversation.all
    end
  end

  def new
  end

  def create
    conversation = if @parent
      @parent.conversation.new(conversation_params)
    else
      Conversation.new(conversation_params)
    end

    if conversation.save
      head :created, location: conversation_url(conversation)
    else
      head :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    head @conversation.destroy ? :no_content :unprocessable_entity
  end

  private

  def conversation_params
    params.require(:conversation).permit(:id, :subject, :body, :sender_id, :recipient_id)
  end

end
