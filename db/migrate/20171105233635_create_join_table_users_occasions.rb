class CreateJoinTableUsersOccasions < ActiveRecord::Migration[5.0]
  def change
    create_table :occasions_users do |t|
      t.references :occasion, index: true
      t.references :user, index: true
      t.references :giver, index: true
      t.references :reciever, index: true
    end

    add_foreign_key :occasions_users, :occasions
    add_foreign_key :occasions_users, :users

    add_foreign_key :occasions_users, :occasions_users, column: :giver_id
    add_foreign_key :occasions_users, :occasions_users, column: :reciever_id

  end
end
