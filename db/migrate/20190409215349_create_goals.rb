class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :city
      t.string :country
      t.string :tourist_attraction
      t.integer :user_id
    end
  end
end
