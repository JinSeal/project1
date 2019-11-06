class ApplicationController < ActionController::Base
    include ApplicationHelper
    before_action :fetch_user, :set_variable, :get_api_key
    helper_method :sort_column, :sort_direction

    private
    def fetch_user
        @current_user = User.find_by :id => session[:user_id] if session[:user_id].present?
        session[:user_id] = nil unless @current_user.present?
    end

    def check_for_login
        redirect_to login_path unless @current_user.present?
    end

    def check_for_admin
        redirect_to root_path unless @current_user.present? && @current_user.admin?
    end

    def set_variable
        @strategy = ['Capital Growth','Dividend Income', 'Balanced']
        @portfolios = @current_user.portfolios.order(sort_column + " " + sort_direction) if @current_user.present?
    end

    def get_api_key
        StockQuote::Stock.new(:api_key => 'pk_16a849fd637243a79fff90fa4d42bc5d')
    end

    def sort_column
        @current_user.transactions.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
