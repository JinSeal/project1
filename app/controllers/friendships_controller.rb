class FriendshipsController < ApplicationController
    before_action :check_for_login
  def show
    @user = @current_user
  end

  def index
    @users = User.all
  end

  def create
    @friendship = @current_user.friendships.new(friendship_params)
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to friendships_path
    else
      flash[:error] = "Unable to add friend."
      redirect_to friendships_path
    end
  end

  def destroy
    friendship = @current_user.friendships.find(params[:id])
    friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to friendship_path
  end

    private
    def friendship_params
        params.permit(:friend_id)
    end
end
