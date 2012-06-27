class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.float :elo
      t.integer :games_played
      t.integer :wins
      t.integer :losses

      t.timestamps
    end
  end
end
