# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.destroy_all
u1 = User.create(:email => 'ga1@ga.co', :password => 'chicken', :username=>'Seal', :full_name=> "Sheldon Cooper", :account_no => '12324212', :mobile => '0412345678', :address => '1 Market Street', :strategy=> 'Dividend Income', :balance => 50000)
u2 = User.create(:email => 'ga2@ga.co', :password => 'chicken', :username=>'BigCat', :mobile => '0411341228', :address => '1 Market Street', :full_name=>'Jordon Wilson', :account_no => '32224212', :balance => 0, :admin => true)

100.times do
    User.create(:email => Faker::Internet.unique.email,
    :password =>'chicken',
    :username => Faker::FunnyName.name,
    :full_name => Faker::Name.name,
    :account_no => Faker::Number.unique.number(digits: 8),
    :mobile => Faker::PhoneNumber.cell_phone,
    :address => Faker::Address.full_address, :strategy => ['Balanced', 'Dividend Income', 'Capital Growth'].sample,
    :balance => Faker::Number.number(digits:5))
    end
puts "#{ User.count } users created"

Portfolio.destroy_all
p1 = Portfolio.create(:name => 'Portfolio 1', :user_id => 1)
p2 = Portfolio.create(:name => 'Portfolio 2', :user_id => 1)
puts "#{ Portfolio.count } portfolios created"

Transaction.destroy_all
t1 = Transaction.create(:settlment_date => "2019-01-03", :portfolio_id => 1, :trade_type => "Buy", :symbol => 'GOOG', :number => 5, :price => 1045.85, :on_hand => 5, :avg_cost => 1045.85)
t2 = Transaction.create(:settlment_date => "2019-01-01", :portfolio_id => 1, :trade_type => "Buy", :symbol => 'MSFT', :number => 100, :price => 102.06, :on_hand => 100, :avg_cost => 102.06)
t3 = Transaction.create(:settlment_date => "2019-05-10", :portfolio_id => 1, :trade_type => "Buy", :symbol => 'AAPL', :number => 500, :price => 197.18, :on_hand => 500, :avg_cost => 197.18)
t4 = Transaction.create(:settlment_date => "2019-04-23", :portfolio_id => 1, :trade_type => "Buy", :symbol => 'MSFT', :number => 500, :price => 129.77, :on_hand => 600, :avg_cost => 125.15)
t5 = Transaction.create(:settlment_date => "2019-05-06", :portfolio_id => 1, :trade_type => "Sell", :symbol => 'MSFT', :number => 50, :price => 128.15, :on_hand => 550, :avg_cost => 125.15)
t6 = Transaction.create(:settlment_date => "2019-05-06", :portfolio_id => 1, :trade_type => "Sell", :symbol => 'MSFT', :number => 50, :price => 128.15, :on_hand => 500, :avg_cost => 120.53)
t7 = Transaction.create(:settlment_date => "2019-05-06", :portfolio_id => 1, :trade_type => "Sell", :symbol => 'MSFT', :number => 50, :price => 128.15, :on_hand => 450, :avg_cost => 120.53)
t8 = Transaction.create(:settlment_date => "2019-06-24", :portfolio_id => 1, :trade_type => "Sell", :symbol => 'MSFT', :number => 100, :price => 137.78, :on_hand => 350, :avg_cost => 120.53)
t9 = Transaction.create(:settlment_date => "2019-06-24", :portfolio_id => 1, :trade_type => "Sell", :symbol => 'MSFT', :number => 50, :price => 137.78, :on_hand => 300, :avg_cost => 120.53)
t10 = Transaction.create(:settlment_date => "2019-06-03", :portfolio_id => 1, :trade_type => "Buy", :symbol => 'FB', :number => 500, :price => 164.15, :on_hand => 500, :avg_cost => 164.15)
t11 = Transaction.create(:settlment_date => "2019-06-24", :portfolio_id => 1, :trade_type => "Sell", :symbol => 'FB', :number => 500, :price => 192.60, :on_hand => 0, :avg_cost => 164.15)
t12 = Transaction.create(:settlment_date => "2019-07-23", :portfolio_id => 1, :trade_type => "Buy", :symbol => 'TWTR', :number => 1000, :price => 36.77, :on_hand => 100, :avg_cost => 36.77)
t13 = Transaction.create(:settlment_date => "2019-09-06", :portfolio_id => 1, :trade_type => "Sell", :symbol => 'TWTR', :number => 50, :price => 46.33, :on_hand => 500, :avg_cost => 36.77)
t14 = Transaction.create(:settlment_date => "2019-09-10", :portfolio_id => 1, :trade_type => "Sell", :symbol => 'TWTR', :number => 305, :price => 45.30, :on_hand => 195, :avg_cost => 36.77)
t15 = Transaction.create(:settlment_date => "2019-09-23", :portfolio_id => 1, :trade_type => "Buy", :symbol => 'FB', :number => 50, :price => 170.90, :on_hand => 500, :avg_cost => 170.90)
puts "#{ Transaction.count } transactions created"

Watchlist.destroy_all
w1 = Watchlist.create(:symbol => "GOOG", :user_id => 1)
w2 = Watchlist.create(:symbol => "MSFT", :user_id => 1)
w3 = Watchlist.create(:symbol => "FB", :user_id => 1)
w4 = Watchlist.create(:symbol => "AAPL", :user_id => 1)
w5 = Watchlist.create(:symbol => "TWTR", :user_id => 1)
puts "#{ Watchlist.count } watchlist items created"

Product.destroy_all
pt1 = Product.create(:symbol => "0001", :name => "Fund No.1", :price => 1000, :return => 0.082, :description => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
pt1 = Product.create(:symbol => "0002", :name => "Fund No.2", :price => 789, :return => 0.054, :description => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
puts "#{ Product.count } products created"
