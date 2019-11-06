class TransactionsController < ApplicationController

    def new
        @new_transaction = Transaction.new
        @new_transaction.symbol = new_params[:symbol].upcase
        @new_transaction.portfolio_id = new_params[:portfolio_id]
        begin
            info = StockQuote::Stock.quote new_params[:symbol]
            @new_transaction.price = info.latest_price
        rescue
            @msg = "* No Stock Found"
        end
    end

    def create
        transaction = Transaction.create create_params
        transaction.update(:on_hand => calc_share_num(create_params[:portfolio_id], create_params[:symbol], create_params[:number], create_params[:price], create_params[:trade_type]), :avg_cost => calc_avg_price(create_params[:portfolio_id], create_params[:symbol],
            create_params[:price], create_params[:number],  create_params[:trade_type]), :settlment_date => Date.today.strftime("%Y-%m-%d"))
            total = create_params[:number].to_i * create_params[:price].to_f
            balance = @current_user.balance
            if create_params[:trade_type] == "Buy"
                @current_user.update(:balance => (balance - total))
            else
                @current_user.update(:balance => (balance + total))
            end
            redirect_to transactions_path
        end

        def index
            @all_transactions = @current_user.transactions.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 12, :page => params[:page])
            @all_transactions = @current_user.transactions.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 12, :page => params[:page]) if params[:search].present?
        end

        private
        def new_params
            params.require(:transaction).permit(:symbol, :portfolio_id)
        end

        def create_params
            params.require(:transaction).permit(:symbol, :trade_type, :portfolio_id, :number, :price)
        end

    end
