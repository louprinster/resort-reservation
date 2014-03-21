class Rental < ActiveRecord::Base
  has_many :rental_items, class_name: "RentalItem", foreign_key: "rental_id"
end