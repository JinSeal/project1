class AddScopeToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :scope, :string
  end
end
