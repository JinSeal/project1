module ApplicationHelper

    def get_symbols(port_id)
        @current_user.transactions.where(portfolio_id: port_id).pluck(:symbol).uniq!
    end

    def get_transactions(port_id, symbol)
        @current_user.transactions.where(portfolio_id: port_id).where(symbol: symbol)
    end

    def calc_share_num(port_id, symbol)
        number = 0
        shares = get_transactions(port_id, symbol)
        number += shares.where(trade_type: 'Buy').sum(:number) if shares.where(trade_type: 'Buy').present?
        number -=
        shares.where(trade_type: 'Sell').sum(:number) if shares.where(trade_type: 'Sell').present?
        number
    end

    def cal_avg_price(port_id, symbol)
        shares = get_transactions(port_id, symbol)
        price = 0
        total_cost = shares.where(trade_type: 'Buy').map{|e| e.number*e.price}.inject(&:+)
        avg_cost = total_cost/ shares.where(trade_type: 'Buy').sum(:number)
    end
    def check_empty_portfolio(port_id)
        if get_symbols(port_id).present?
            get_symbols(port_id).map{|symbol| calc_share_num(port_id, symbol)}.inject(&:+).zero?
        else
        return true
        end
    end
end
