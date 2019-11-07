class PostsController < ApplicationController
    before_action :check_for_login, :get_posts, :filter_scope

    def create
        post = Post.create posts_params
        post.update(:user_id => @current_user.id)
        redirect_to posts_path
    end

    def update
    end

    def destroy
        post = Post.find params[:id]
        post.destroy
        redirect_to posts_path
    end

    def index
        @post = Post.new
    end

    def show
        @post = Post.find params[:id]
        render :index
    end

    def edit
      render :index
    end

    private
    def posts_params
        params.require(:post).permit(:title, :content)
    end

    def filter_scope
      @filter_scope = Post.new

      if params[:post].present?
          @posts = @posts.where(:user_id => @current_user.friendships) if params[:post][:scope] == 'Friends'

          @posts = @posts.where(user_id: @current_user[:id]) if params[:post][:scope] =='Only Me'

          @filter_scope[:scope] = params[:post][:scope] if params[:post][:scope].present?
      end
    @filter_scope
    @selections = ['All', 'Friends', 'Only Me']
  end

  def get_posts
    @posts = Post.all

    unless @current_user.admin
        first = Post.where(:scope => ['All', nil])
        second = Post.where(:scope => 'Friends', :user_id => @current_user.inverse_friend_ids)
        @posts = first.or(second)
    end
    @posts = @posts.order('created_at DESC')
  end
end
