require 'pry'

class ToolsController < ApplicationController

  before_action :is_authenticated?
  before_action :set_tool, only: [:show, :edit, :update, :destroy]

  def index
    @tools = Tool.all
  end

  def new
  end

  def create
    @tool = Tool.new(tool_params)
    @tool.save
    redirect_to @tool
  end

  def show
    # @tool = Tool.find_by_id(params[:id])
  end

  def edit
  end

  def update
    if @tool.update(params[:tool].permit(:name, :category, :description, :availability))
      redirect_to @tool
    else
      render :edit
    end
  end

  private

    def tool_params
      params.require(:tool).permit(:id, :user_id, :name, :category, :description, :photos, :availability)
    end

    def set_tool
      @tool = Tool.find(params[:id])
    end

end
