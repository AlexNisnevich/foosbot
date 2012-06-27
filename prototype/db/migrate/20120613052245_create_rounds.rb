class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :game_id
      t.integer :round_number
      t.integer :black_team_score
      t.integer :yellow_team_score

      t.timestamps
    end
  end
end
