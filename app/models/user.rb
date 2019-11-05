class User < ApplicationRecord
    has_many :portfolios
    has_many :transactions, through: :portfolios
    has_secure_password
    has_many :watchlists

    validates :email, :presence => true, :uniqueness => true

end
