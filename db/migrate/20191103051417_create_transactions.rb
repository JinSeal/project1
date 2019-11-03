class CreateTransactions < ActiveRecord::Migration[6.0]
    def change
        create_table :transactions do |t|
            t.date :settlment_date
            t.integer :portfolio_id
            t.string :trade_type
            t.string :symbol
            t.integer :fund_id
            t.integer :number
            t.numeric :price

            t.timestamps
        end
    end
end
