class Rates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.integer  :reservation_item_id
      t.date     :date
      t.float    :amount
    end

  end
end
