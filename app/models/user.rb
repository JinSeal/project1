class User < ApplicationRecord
    has_many :portfolios
    has_many :transactions, through: :portfolios
    has_secure_password
    has_many :watchlists

    validates :email, :presence => true, :uniqueness => true
    validates :balance, :numericality => { :greater_than_or_equal_to => 0 }

end
