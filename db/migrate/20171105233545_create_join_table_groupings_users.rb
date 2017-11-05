class CreateJoinTableGroupingsUsers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :groupings, :users do |t|
      t.index [:grouping_id, :user_id]
      t.index [:user_id, :grouping_id]
    end

    add_foreign_key :groupings_users, :groupings
    add_foreign_key :groupings_users, :users
  end
end
