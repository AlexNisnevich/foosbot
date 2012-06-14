class AddGravatarIdToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :gravatar_id, :string
  end
end
