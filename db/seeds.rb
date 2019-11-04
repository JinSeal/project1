# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.destroy_all
u1 = User.create(:email => 'ga1@ga.co', :password => 'chicken', :username=>'Seal', :full_name=> "Sheldon Cooper", :account_no => '12324212', :mobile => '0412345678', :address => '1 Market Street', :strategy=> 'Dividend Income', :balance => 50000.00)
u2 = User.create(:email => 'ga2@ga.co', :password => 'chicken', :account_no => '32224212', :balance => 10000.00)
puts "#{ User.count } users created"

Portfolio.destroy_all
p1 = Portfolio.create(:name => 'Portfolio 1', :user_id => 1)
p2 = Portfolio.create(:name => 'Portfolio 2', :user_id => 1)
p3 = Portfolio.create(:name => 'Portfolio 3')
p4 = Portfolio.create(:name => 'Portfolio 4')
puts "#{ Portfolio.count } portfolios created"

Transaction.destroy_all
t1 = Transaction.create(:settlment_date => "2019-01-03", :portfolio_id => 1, :trade_type => "Buy", :symbol => 'GOOG', :number => 5, :price => 1045.85, :on_hand => 5, :avg_cost => 1045.85)
t2 = Transaction.create(:settlment_date => "2019-01-01", :portfolio_id => 1, :trade_type => "Buy", :symbol => 'MSFT', :number => 100, :price => 102.06, :on_hand => 100, :avg_cost => 102.06)
t3 = Transaction.create(:settlment_date => "2019-04-23", :portfolio_id => 1, :trade_type => "Sell", :symbol => 'MSFT', :number => 50, :price => 129.77, :on_hand => 50, :avg_cost => 102.06)
t4 = Transaction.create(:settlment_date => "2019-04-23", :portfolio_id => 1, :trade_type => "Buy", :symbol => 'MSFT', :number => 100, :price => 129.77, :on_hand => 150, :avg_cost => 120.53)
t5 = Transaction.create(:settlment_date => "2019-04-23", :portfolio_id => 1, :trade_type => "Sell", :symbol => 'MSFT', :number => 50, :price => 129.77, :on_hand => 100, :avg_cost => 120.53)
puts "#{ Transaction.count } transactions created"
