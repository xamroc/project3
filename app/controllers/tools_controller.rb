class ToolsController < ApplicationController
  def index
  end

  def new
  end

  def create
    @tool = Tool.new(params[:tool])
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

  def show
  end

  private
    def tool_params
      params.require(:tool).permit(:name, :category, :description, :photos, :price, :tag)
    end

end
