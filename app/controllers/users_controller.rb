class UsersController < ApplicationController
    before_action :check_for_login, :except => [:new]

    def new
        @user = User.new
    end

    def create
        @user = User.create user_params
        if @user.save
            session[:user_id] = @user.id
            redirect_to @user
        else
            render :new
        end
    end

    def edit

    end

    def update
        user = @current_user
        user.update profile_params
        user.save
        redirect_to edit_user_path
    end
    private

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def profile_params
        params.require(:user).permit(:username, :full_name, :dob, :address, :mobile, :image, :subscription, :strategy)
    end
end
