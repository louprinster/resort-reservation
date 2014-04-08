class ReservationItems < ActiveRecord::Migration
  def change
    create_table :reservation_items do |t|
      t.string  :status
      t.date    :start_date
      t.date    :end_date
      t.integer :adults
      t.integer :children
      t.integer :pets
      t.float   :tax
      t.integer :reservation_id
      t.integer :rental_item_id
    end
  end
end
