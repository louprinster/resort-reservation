class Reservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.date    :start_date
      t.date    :end_date
      t.integer :adults
      t.integer :children
      t.integer :pets
      t.float   :tax
      t.integer :rental_item_id
      t.integer :customer_id
      t.string  :status
    end
  end
end
