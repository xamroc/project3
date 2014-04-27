require 'pry'

class ToolsController < ApplicationController

  respond_to :json
  before_action :is_authenticated?, only: [:new, :edit, :update, :destroy]
  before_action :set_tool, only: [:edit, :update, :destroy]
  before_action :get_user

  def index
    @tools = if params[:id]
      user_clause = @user ? "and user_id = #{@user.id}" : ""

      Tool.where("id in (?) #{user_clause}", params[:id].split(','))
    elsif params[:search].present?
      Tool.where("lower(name) like ? OR lower(category) like ? ", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%")
    else
      @user ? @user.tools_owned : Tool.all
    end

    @transactions = Transaction.where('tool_id = ?', @tools[0]) if @tools.length == 1
  end

  def new
  end

  def create
    tool = if @user
      @user.tool.new(tool_params)
    else
      Tool.new(tool_params)
    end
    user = current_user
    tool.owner = user
    if tool.save
      head :created
    else
      head :unprocessable_entity
    end
  end

  def edit
    # binding.pry
    # user = current_user
    # tool.owner = user
  end

  def update
    if @tool.update(tool_params)
      head :no_content
      # redirect_to root_url, notice: "You have edit your tool successfully"
    else
      # render :edit
      head :unprocessable_entity
    end
  end

  def destroy
    head @tool.destroy ? :no_content : :unprocessable_entity
  end

  private

    def tool_params
      params.require(:tool).permit(:id, :user_id, :name, :category, :description, :avatar, :availability, :avatar_cache, :remove_avatar)
    end

    def set_tool
      head :not_found unless @tool = if @user
        @user.tools.where('id in ?', params[:id]).take
      else
        Tool.where('id in (?)', params[:id]).take
      end
    end

    def get_user
      if params[:user_id]
        head :bad_request unless @user =
          User.includes(:tools).where('id = ?', params[:user_id]).take
      end
    end

end
