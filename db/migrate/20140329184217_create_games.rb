class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.datetime :start_at
      t.datetime :created_at
      t.integer :capacity
      t.integer :skill_level
      # patch for has_one relationship
      t.integer :creator_id
      t.references :court
    end
  end
end
