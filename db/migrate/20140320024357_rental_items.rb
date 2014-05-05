class RentalItems < ActiveRecord::Migration
  def change
    create_table :rental_items do |t|
      t.string  :name
      t.integer :rental_type_id
      t.string  :bed_config
      t.string  :status
      t.text    :notes
    end
  end
end
