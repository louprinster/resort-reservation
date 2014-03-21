class RentalItems < ActiveRecord::Migration
  def change
    create_table :rental_items do |t|
      t.string  :name
      t.integer :rental_id
      t.string  :bed_config
      t.string  :status
    end
  end
end
