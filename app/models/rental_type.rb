class RentalType < ActiveRecord::Base
  has_many :rental_items, class_name: "RentalItem", foreign_key: "rental_type_id"
end

# Method calls:  RentalType.find(1).rental_items