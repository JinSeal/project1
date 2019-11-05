class WatchlistsController < ApplicationController
  def new
    @watchlist = Watchlist.new
    render :template => 'users/show'
  end

  def create
     watchlist = Watchlist.create(watchlist_params)
     watchlist.update(:user_id => @current_user.id)
     redirect_to root_path
  end


  def destroy
      watchlist = Watchlist.find params[:id]
      watchlist.destroy
      redirect_to root_path
  end

    private
    def watchlist_params
        params.require(:watchlist).permit(:symbol)
    end

end
