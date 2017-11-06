class AddColumnToUserFirstToggle < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_time_toggle, :boolean, default: true
  end
end
