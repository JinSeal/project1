class WatchlistsController < ApplicationController
    before_action :check_for_login
  def new
    @watchlist = Watchlist.new
    render :template => 'users/show'
  end

  def create
    unless @current_user.watchlists.pluck(:symbol).include?(params[:watchlist][:symbol].upcase)
     watchlist = Watchlist.create(watchlist_params)
     watchlist.update(:user_id => @current_user.id)
    end
     redirect_to root_path
  end


  def destroy
      watchlist = Watchlist.find params[:id]
      watchlist.destroy
      redirect_to root_path
  end

  def index
      @info = StockQuote::Stock.quote params[:symbol]
      render :show
  end

  private
  def watchlist_params
      params.require(:watchlist).permit(:symbol)
  end

end
