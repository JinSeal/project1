module ApplicationHelper

    def get_symbols(port_id)
        @current_user.transactions.where(portfolio_id: port_id).pluck(:symbol).uniq!
    end

    def get_transactions(port_id, symbol)
        @current_user.transactions.where(portfolio_id: port_id).where(symbol: symbol)
    end

    def calc_share_num(port_id, symbol, number, price, trade_type)

        if @current_user.transactions.where(portfolio_id: port_id).count == 1
            on_hand = number
        else
        last_transaction = @current_user.transactions.where(portfolio_id: port_id).last(2).first
        if trade_type == "Buy"
            on_hand = last_transaction.on_hand.to_i + number.to_i
        else
            on_hand = last_transaction.on_hand.to_i - number.to_i
        end
        end
    end

    def calc_avg_price(port_id, symbol, price, number, trade_type)

        if @current_user.transactions.where(portfolio_id: port_id).count == 1
            avg_cost = price
        else
        last_transaction = @current_user.transactions.where(portfolio_id: port_id).last(2).first
        if trade_type == "Buy"
            avg_cost = (price.to_f * number.to_i + last_transaction.avg_cost.to_f * last_transaction.on_hand.to_i)/(last_transaction.on_hand.to_i + number.to_i)
        else
            avg_cost = last_transaction.avg_cost
        end
        end
    end

    def calc_share_num2(port_id, symbol)
            number = 0
            shares = get_transactions(port_id, symbol)
            number += shares.where(trade_type: 'Buy').sum(:number) if shares.where(trade_type: 'Buy').present?
            number -=
            shares.where(trade_type: 'Sell').sum(:number) if shares.where(trade_type: 'Sell').present?
            number
    end

    def check_empty_portfolio(port_id)
        if get_symbols(port_id).present?
            get_symbols(port_id).map{|symbol| calc_share_num2(port_id, symbol)}.inject(&:+).zero?
        else
        return true
        end
    end
end
