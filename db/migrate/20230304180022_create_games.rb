class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :name
      t.datetime :deadline, null: false
      t.integer :points_limit, null: false
      t.integer :teams_limit, null: false
      t.timestamps
    end
  end
end
