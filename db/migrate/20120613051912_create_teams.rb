class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :game_id
      t.integer :first_player_id
      t.integer :second_player_id
      t.boolean :black_team
      t.boolean :first_player_on_defense
      t.boolean :first_to_switch

      t.timestamps
    end
  end
end
