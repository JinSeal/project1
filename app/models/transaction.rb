class Transaction < ApplicationRecord

    belongs_to :portfolio
    belongs_to :product, foreign_key: "symbol", :optional=>true

    def self.search(search)
      if search
        where('symbol LIKE ? OR trade_type LIKE ?', "%#{search.upcase}%", "%#{search.titleize}%")
      else
        all()
      end
    end
end
