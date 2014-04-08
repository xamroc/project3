require 'pry'

class ToolsController < ApplicationController

  before_action :is_authenticated?, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_message, only: [:show, :edit, :update, :destroy]

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
    @tool = Tool.find(params[:id])
  end

  def edit
  end

  def update
  end

  private

    def tool_params
      params.require(:tool).permit(:name, :category, :description, :photos, :price, :tag)
    end

    def set_message
    @tool = Tool.find(params[:id])
  end

end
