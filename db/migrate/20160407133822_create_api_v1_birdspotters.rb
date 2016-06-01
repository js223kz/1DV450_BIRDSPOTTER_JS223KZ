class CreateApiV1Birdspotters < ActiveRecord::Migration
  def change
    create_table :api_v1_birdspotters do |t|
      t.string :user_name,  limit: 30, unique: true
      t.string :email, limit: 70, unique: true
      t.string :password_digest 
      t.string :user_token
      t.timestamps null: false
    end
  end
end
