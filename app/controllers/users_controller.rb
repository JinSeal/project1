class UsersController < ApplicationController
    before_action :check_for_login, :except => [:new, :create]
    before_action :check_for_admin, :only=>[:index]

    def show
        redirect_to users_path if @current_user.admin
        @user = User.find params[:id] if params[:id].present?
        @portfolios = @current_user.portfolios
    end

    def new
        @user = User.new
    end

    def create
        @user = User.create user_params
        if @user.save
            session[:user_id] = @user.id
            redirect_to @user
        else
            render new_user_path
        end
    end

    def edit
        @user = User.find params[:id]
    end

    def update
        user = User.find params[:id]
        user.update profile_params
        user.save
        redirect_to edit_user_path
    end

    def index
        (@filterrific = initialize_filterrific(
            User,
            params[:filterrific],
            select_options: {
                :sorted_by => User.options_for_sorted_by,
                :with_strategy => ['Dividend Income', 'Balanced', 'Capital Growth']
            })) || return @users = @filterrific.find.page(params[:page])

        respond_to do |format|
            format.html
            format.js
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def profile_params
        params.require(:user).permit(:username, :full_name, :dob, :address, :mobile, :image, :subscription, :strategy, :account_no)
    end

end
