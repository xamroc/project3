class TransactionsController < ApplicationController

  respond_to :json
  # before_action :is_authenticated?, only: [:new, :edit, :update, :destroy]
  before_action :set_transaction, only: [:update, :destroy]
  before_action :get_parent

  def index
    @transactions = if params[:id]
      Transaction.where("id in (?) #{@parent_clause}", params[:id].split(','))
    else
      @parent ? @parent.transactions : Transaction.all
    end

  end

  def new
  end

  def create
    transaction = if @parent
      @parent.transaction.new(transaction_params)
    else
      Transaction.new(article_params)
    end

    if transaction.save
      head :created, location: transaction_url(transaction)
    else
      head :unprocessable_entity
    end
  end

  def show
  end

  def update
    head @transaction.update(transaction_params) ? :no_content : :unprocessable_entity
  end

  def destroy
    head @transaction.destroy ? :no_content : :unprocessable_entity
  end

  private

    def transaction_params
      params.require(:transaction).permit(:id, :transaction_date, :rent_date, :return_date, :parent_id, :tool_id)
    end

    def set_transaction
      head :not_found unless @transaction
        Transaction.where('id = ? #{@parent_clause}', params[:id]).take
    end

    def get_parent
      @parent_clause = if params[:user_id]
        head :bad_request unless @parent = User.where('id = ?', params[:user_id]).take
        "and user_id = #{@parent.id}"
      elsif params[:tool_id]
        head :bad_request unless @parent =
          Tool.where('id = ?', params[:tool_id]).take
        "and tool_id = #{@parent.id}"
      else
        ""
      end
    end
end