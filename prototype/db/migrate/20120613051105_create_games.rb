class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :black_team_score
      t.integer :yellow_team_score

      t.timestamps
    end
  end
end
