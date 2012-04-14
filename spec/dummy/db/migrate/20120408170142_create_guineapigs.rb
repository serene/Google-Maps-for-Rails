class CreateGuineapigs < ActiveRecord::Migration
  def change
    create_table :guineapigs do |t|
      t.string :name
      t.string :picture
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps

      t.timestamps
    end
  end
end
