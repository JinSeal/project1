class PortfoliosController < ApplicationController

    def new
        @portfolio = Portfolio.new
        render :template => 'users/show'
    end

    def create
        portfolio = Portfolio.create(portfolio_params)
        portfolio.update(:user_id => @current_user.id)
        redirect_to root_path
    end

    def edit
        @portfolio = Portfolio.find params[:id]
        render :template => 'users/show'
    end

    def update
        portfolio = Portfolio.find params[:id]
        portfolio.update portfolio_params
        redirect_to root_path
    end

    def show
    end

    def destroy
        portfolio = Portfolio.find params[:id]
        portfolio.destroy
        redirect_to root_path
    end

    private
    def portfolio_params
        params.require(:portfolio).permit(:name)
    end

end
