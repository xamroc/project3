require 'pry'

class TransactionsController < ApplicationController

  before_action :is_authenticated?, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  def index
    @transactions = Transaction.all
  end

  def new
  end

  def create
    @user = current_user
    @transaction = Transaction.new(transaction_params)
    @transaction.user = @user
    @transaction.save
    redirect_to @transaction
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
      @transaction = Transaction.find(params[:id])
    end
end