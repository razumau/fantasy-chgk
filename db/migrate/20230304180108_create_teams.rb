class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.string :city, null: false
      t.integer :price, null: false
      t.integer :points
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
