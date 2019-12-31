module ApplicationHelper

  def get_symbols(port_id)
    symbols = @current_user.transactions.where(portfolio_id: port_id).pluck(:symbol)
    symbols = symbols.uniq if symbols.length > 1
    symbols
  end

  def get_transactions(port_id, symbol)
    @current_user.transactions.where(portfolio_id: port_id).where(symbol: symbol)
  end

  def calc_share_num(port_id, symbol, number, price, trade_type)
    if @current_user.transactions.where(portfolio_id: port_id).where(symbol: symbol).count == 1
      on_hand = number
    else
      last_transaction = @current_user.transactions.where(portfolio_id: port_id).where(symbol: symbol).last(2).first
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

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, request.parameters.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

  def human_boolean(bool_string)
    bool_string ? "Yes" : "No"
  end

  def get_portfolio_details
    portfolio_details = []
    @current_user.portfolio_ids.each do |folio_id|
      if get_symbols(folio_id).present?
        get_symbols(folio_id).each do |symbol|
          info = StockQuote::Stock.quote symbol
          stock_on_hand = @current_user.transactions.where(portfolio_id: folio_id).where(symbol: symbol).last.on_hand.to_i
          avg_cost = @current_user.transactions.where(portfolio_id: folio_id).where(symbol: symbol).last.avg_cost.to_f

          portfolio_detail = {:folio_id => folio_id, :symbol => symbol, :company_name => info.company_name, :on_hand => stock_on_hand, :avg_cost => avg_cost, :latest_price => info.latest_price, :change_percent => info.change_percent, :profit => info.change}

          portfolio_details.append( portfolio_detail)

        end
      end
    end
    portfolio_details
    # raise
  end

  def get_watchlist_info
    watchlists_info = []
    @current_user.watchlists.each do |item|
      info = StockQuote::Stock.quote item.symbol
      selected_info = {:id => item.id, :symbol => item.symbol, :company =>info.company_name, :latest_price => info.latest_price, :change_percent => info.change_percent, :previous_close => info.previous_close, :open => info.open, :change => info.change}
      watchlists_info.append(selected_info)
    end
    watchlists_info
  end

  def get_portfolio_summary
    portfolios_summary = []

    portfolios_details = get_portfolio_details()

    if portfolios_details.present?
      arrays_by_folio_id = @current_user.portfolio_ids.map{|id| portfolios_details.select{|info| info[:folio_id] == id }}.reject {|el| el.empty? }

      arrays_by_folio_id.each{|folio_details_by_id|
        stats_array =[]
        folio_details_by_id.each{|share_info|
          purchase_price = share_info[:on_hand].to_i * share_info[:avg_cost].to_f
          today_change = share_info[:on_hand].to_i * share_info[:profit].to_f
          total_profit = share_info[:on_hand].to_i * (share_info[:latest_price].to_f - share_info[:avg_cost].to_f)
          hash = {:purchase_price => purchase_price, :today_change => today_change, :total_profit => total_profit}
          stats_array.append(hash)
        }
        id = folio_details_by_id[0][:folio_id]
        name = Portfolio.find(id)[:name]
        investment = stats_array.pluck(:purchase_price).inject(&:+)
        today_change = stats_array.pluck(:today_change).inject(&:+)
        total_profit = stats_array.pluck(:total_profit).inject(&:+)

        summary = {:id => id, :name => name, :investment => investment , :today_change => today_change, :total_profit => total_profit}

        portfolios_summary.append(summary)
      }
      empty_portfolios_id = @current_user.portfolio_ids.select{|el| @current_user.transactions.where(portfolio_id: el).blank?}
      empty_portfolios_id.each{|id|
        name = Portfolio.find(id)[:name]
        summary = {:id => id, :name => name, :investment => 0 , :today_change => 0, :total_profit => 0}
        portfolios_summary.append(summary)

      }

      portfolios_summary
    end
  end

  def investment_summary
    portfolios_summary = get_portfolio_summary()
    if get_portfolio_summary.present?
      total_profit = portfolios_summary.pluck(:total_profit).sum
      total_investment = portfolios_summary.pluck(:investment).sum
      {:total_profit => total_profit, :total_investment=> total_investment}
    end
  end

  def colorCell(figure, type)
    if type == "percent"
        input = number_to_percentage(figure * 100)
    else
        input = number_to_currency(figure)
    end
    if figure > 0
      content_tag(:td, input, style: "color: green")
    elsif figure < 0
      content_tag(:td, input, style: "color: red")
    else
      content_tag(:td, input,style: "color: black")
    end
  end

  def colorSpan(figure)
    input = number_to_currency(figure)
    if figure > 0
      content_tag(:span, input, style: "color: green")
    elsif figure < 0
      content_tag(:span, input, style: "color: red")
    else
      content_tag(:span, input,style: "color: black")
    end
  end

end
