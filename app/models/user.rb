class User < ApplicationRecord
    has_many :portfolios
    has_many :transactions, through: :portfolios
    has_secure_password

    validates :email, :presence => true, :uniqueness => true

end
