class CreateUsers < ActiveRecord::Migration[6.0]
    def change
        create_table :users do |t|
            t.text :email
            t.text :username
            t.text :full_name
            t.string :account_no
            t.text :strategy
            t.text :address
            t.text :mobile
            t.float :balance
            t.text :image
            t.text :password, :default => 'chicken'
            t.boolean :subscription, :default => true
            t.date :dob
            t.boolean :admin, :default => false

            t.timestamps
        end
    end
end
