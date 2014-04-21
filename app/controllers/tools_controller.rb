require 'pry'

class ToolsController < ApplicationController

  respond_to :json
  before_action :is_authenticated?, only: [:new, :edit, :update, :destroy]
  before_action :set_tool, only: [:update, :destroy]

  def index
    @tools = if params[:id]
      Tool.where('id in (?)', params[:id].split(','))
    else
      @tools = Tool.all
    end
  end

  def new
  end

  def create
    tool = Tool.new(tool_params)
    if tool.save
      head :created, location: tool_url(tool)
    else
      head :unprocessable_entity
    end
  end

  def show
  end

  def update
    head @tool.update(tool_params) ? :no_content : :unprocessable_entity
  end

  def destroy
    head @tool.destroy ? :no_content : :unprocessable_entity
  end

  private

    def tool_params
      params.require(:tool).permit(:id, :user_id, :name, :category, :description, :photos, :availability)
    end

    def set_tool
      head :not_found unless @tool = Tool.where('id in (?)', params[:id]).take
    end

end
