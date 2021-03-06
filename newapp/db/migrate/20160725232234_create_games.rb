class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :label
      t.string :full_name

      t.integer :home_team_id
      t.integer :away_team_id
      t.integer :winning_team_id
      t.integer :home_team_score
      t.integer :away_team_score
      t.integer :spread
      t.datetime :start_time
      t.boolean :finished, default: false

      t.timestamps null: false
    end
  end
end
