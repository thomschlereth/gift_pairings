class CreateJoinTableUsersOccasions < ActiveRecord::Migration[5.0]
  def change
    create_join_table :occasions, :users do |t|
      t.index [:occasion_id, :user_id]
      t.index [:user_id, :occasion_id]
    end

    add_foreign_key :occasions_users, :occasions
    add_foreign_key :occasions_users, :users
  end
end
