class Rentals < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
      t.string  :category
      t.string  :subcategory
      t.integer :max_occupancy
      t.string  :description
      t.string  :image_filename
      t.string  :image_alt
      t.integer :num_bedrooms
      t.integer :num_baths
      t.integer :length
      t.integer :width
      t.integer :height
    end
  end
end
