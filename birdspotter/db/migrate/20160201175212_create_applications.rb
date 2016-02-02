class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :application_name
      t.string :application_key
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
