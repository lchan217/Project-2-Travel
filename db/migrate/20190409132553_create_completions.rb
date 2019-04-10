class CreateCompletions < ActiveRecord::Migration
  def change
    create_table :completions do |t|
      t.string :city
      t.string :country
      t.string :tourist_attraction
      t.string :date_visited
      t.integer :user_id
    end
  end
end
