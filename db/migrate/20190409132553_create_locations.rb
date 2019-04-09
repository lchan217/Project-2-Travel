class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :city
      t.string :country
      t.string :tourist_attraction
      t.datetime :date_visited
      t.integer :user_id
    end
  end
end
