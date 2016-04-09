class CreateApiV1Spots < ActiveRecord::Migration
  def change
    create_table :api_v1_spots do |t|
      t.float :latitude
      t.float :longitude
      t.string :address
      t.belongs_to :birdspotter, index: true
      t.timestamps null: false
    end
  end
end
