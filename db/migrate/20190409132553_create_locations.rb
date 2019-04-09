class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :city
      t.string :country
      t.string :tourist_attraction
      t.datetime :past_date
      t.datetime :future_date
      t.integer :user_id
    end
  end
end
