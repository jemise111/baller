class CreateCourts < ActiveRecord::Migration
  def change
    create_table :courts do |t|
      t.string :name
      t.string :location
      t.string :borough
      t.integer :num_courts
      t.float :latitude
      t.float :longitude
    end
  end
end
