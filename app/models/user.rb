class User < ApplicationRecord
    has_many :portfolios
    has_many :transactions, through: :portfolios
    has_secure_password
    has_many :watchlists
    has_many :friendships
    has_many :friends, :through => :friendships
    has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
    has_many :inverse_friends, :through => :inverse_friendships, :source => :user
    has_many :posts



    validates :email, :presence => true, :uniqueness => true
    validates_uniqueness_of :account_no, :allow_nil => true, :allow_blank => true

    scope :sorted_by, ->(sort_option) {
      direction = /desc$/.match?(sort_option) ? "desc" : "asc"
      case sort_option.to_s
      when /^full_name/
        order("LOWER(users.full_name) #{direction}")
      when /^email/
        order("LOWER(users.email) #{direction}")
      when /^strategy/
        order("LOWER(users.strategy) #{direction}")
      when /^account_no/
        order("LOWER(users.account_no) #{direction}")
      else
      end
    }

    def self.options_for_sorted_by
      [
        ['Full Name (a-z)', 'full_name_asc'],
        ['Email (a-z)', 'email_asc'],
        ['Strategy (a-z)', 'strategy_asc'],
        ['Account No. (a-z)', 'account_no_asc']]
    end

    scope :with_strategy, ->(strategies) {
      where(strategy: [*strategies])
    }

    scope :search_query, ->(query) {
      return nil  if query.blank?
      terms = query.downcase.split(/\s+/)
      terms = terms.map { |e|
        (e.tr("*", "%") + "%").gsub(/%+/, "%")
      }
      num_or_conds = 3
      where(
        terms.map { |_term|
          "(LOWER(users.full_name) LIKE ? OR LOWER(users.email) LIKE ? OR LOWER(users.address) LIKE ?)"
        }.join(" AND "),
        *terms.map { |e| [e] * num_or_conds }.flatten,
      )
    }

    filterrific(
       default_filter_params: { sorted_by: 'created_at_desc' },
       available_filters: [
         :sorted_by,
         :search_query,
         :with_strategy
       ]
     )

     def self.search(search)
       if search
         where('symbol LIKE ?', "%#{search.upcase}%")
       else
         all()
       end
     end
end
