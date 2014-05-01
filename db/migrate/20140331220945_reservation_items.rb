class ReservationItems < ActiveRecord::Migration
  def change
    create_table :reservation_items do |t|
      t.string  :category
      t.string  :subcategory
      t.string  :status
      t.date    :start_date
      t.date    :end_date
      t.integer :num_of_days
      t.integer :adults
      t.integer :children
      t.integer :pets
      t.float   :ave_rate
      t.float   :subtotal
      t.float   :tax
      t.float   :total
      t.integer :reservation_id
      t.integer :rental_item_id
    end
  end
end
