class TransactionsController < ApplicationController
  def new
  end

  def create
  end

  def index
    @all_transactions = @current_user.transactions.sort_by(&:portfolio_id).sort_by(&:symbol)
  end
end
