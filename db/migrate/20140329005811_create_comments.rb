class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.boolean :approved
      t.datetime :created_at
      t.references :court
      t.references :user
    end
  end
end
