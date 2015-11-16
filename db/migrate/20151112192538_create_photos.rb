class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :location_id
      t.integer :user_id
      t.string :title
      t.string :image
      t.integer :bytes

      t.timestamps null: false
    end
  end
end
