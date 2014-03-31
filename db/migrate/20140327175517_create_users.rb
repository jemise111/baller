class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.boolean :admin
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :zip_code
      t.boolean :email_display
      t.boolean :notifications
      t.datetime :created_at
    end
  end
end
