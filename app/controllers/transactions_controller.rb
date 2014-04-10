class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  private

    def transaction_params
      params.require(:transaction).permit(:id, :name, :category, :description, :user_id, :tool_id)
    end
end