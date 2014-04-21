require 'pry'

class TransactionsController < ApplicationController

  respond_to :json
  before_action :is_authenticated?, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_transaction, only: [:update, :destroy]

  def index
    @transactions = if params[:id]
      Transaction.where('id in (?)', params[:id].split(','))
    else
      @transactions = Transaction.all
    end
  end

  def new
  end

  def create
    user = current_user
    transaction = Transaction.new(transaction_params)
    transaction.user = user
    if transaction.save
      head :created, location: transaction_url(transaction)
    else
      head :unprocessable_entity
    end
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def update
    if @transaction.update(params[:transaction].permit(:transaction_date, :rent_date, :return_date))
      redirect_to @transaction
    else
      render text: 'Edit transaction failed.'
    end
  end

  def destroy
  end

  private

    def transaction_params
      params.require(:transaction).permit(:id, :transaction_date, :rent_date, :return_date, :user_id, :tool_id)
    end

    def set_transaction
      head :not_found unless @transaction = Transaction.where('id in (?)', params[:id]).take
    end
end