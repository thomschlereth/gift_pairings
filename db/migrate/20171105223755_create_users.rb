class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.references :giver, index: true
      t.references :reciever, index: true
    end

    add_foreign_key :users, :users, column: :giver_id
    add_foreign_key :users, :users, column: :reciever_id
  end
end
