class CreateSpotsBirdsTable < ActiveRecord::Migration
  def change
    create_table :api_v1_birds_spots, :id => false do |t|
      t.integer "bird_id"
      t.integer "spot_id"
    end
    add_index :api_v1_birds_spots, ["bird_id", "spot_id"]
  end
end
