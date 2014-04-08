class Reservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string  :status
      t.integer :customer_id
    end
  end
end
