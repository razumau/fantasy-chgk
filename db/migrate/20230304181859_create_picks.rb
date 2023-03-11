class CreatePicks < ActiveRecord::Migration[7.0]
  def change
    create_table :picks do |t|
      t.references :collection, null: false, foreign_key: true

      t.timestamps
    end
  end
end
