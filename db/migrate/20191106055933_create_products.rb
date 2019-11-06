class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :symbol
      t.string :name
      t.string :manager
      t.float :price
      t.float :return
    t.text :description

      t.timestamps
    end
  end
end
