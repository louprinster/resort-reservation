class RentalItem < ActiveRecord::Base

  belongs_to :rental_type, 
                class_name: "RentalType", 
                foreign_key: "rental_type_id"
  
  has_many   :reservation_items
  
  has_many   :reservations, 
                through: "reservation_items"

# RentalItem.find(1).rental_type
# RentalItem.find(1).reservation_items
# RentalItem.find(1).reservations
  
end