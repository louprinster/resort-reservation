class Rate < ActiveRecord::Base
  belongs_to :reservation_item, class_name: "ReservationItem", 
              foreign_key: "reservation_item_id"
end

# Sample methods:
# Rate.reservation_item
# Rate.reservation_item.reservation
