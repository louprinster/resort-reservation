class Reservation < ActiveRecord::Base

  belongs_to  :customer, 
                class_name: "Customer", 
                foreign_key: "customer_id"
  
  has_many    :reservation_items, 
                class_name: "ReservationItem", 
                foreign_key: "reservation_id"
  
  has_many    :rental_items, 
                through: :reservation_items

end

# Sample calls:
#   Reservation.find(1).customer
#   Reservation.find(1).reservation_items
#   Reservation.find(1).rental_items