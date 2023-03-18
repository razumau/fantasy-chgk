class AddTeamToPick < ActiveRecord::Migration[7.0]
  def change
    add_column :picks, :team_id, :integer
    add_foreign_key :picks, :teams
  end
end
