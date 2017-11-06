class UpdateUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :username, :string
    add_column :users, :password_digest, :string
    add_reference :users, :grouping, index: true
    add_foreign_key :users, :groupings
  end
end
