class RentalTypes < ActiveRecord::Migration
  def change
    create_table :rental_types do |t|
      t.string  :category
      t.string  :subcategory
      t.integer :max_occupancy
      t.text    :description
      t.string  :image_filename
      t.string  :image_alt
      t.integer :num_bedrooms
      t.integer :num_baths
      t.integer :length
      t.integer :width
      t.integer :height
      t.float   :weekday_rate
      t.float   :weekend_rate
      t.float   :monthly_rate
    end
  end
end
