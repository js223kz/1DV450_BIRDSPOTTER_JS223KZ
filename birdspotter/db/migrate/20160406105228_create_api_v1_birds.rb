class CreateApiV1Birds < ActiveRecord::Migration
  def change
    create_table :api_v1_birds do |t|
      t.string :bird_name
      t.string :latin_name
      t.string :regularity

      t.timestamps null: false
    end
  end
end
