class CreateOccasions < ActiveRecord::Migration[5.0]
  def change
    create_table :occasions do |t|
      t.string :title
      t.string :year
    end
  end
end
