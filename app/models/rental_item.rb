class RentalItem < ActiveRecord::Base
  belongs_to :rental, class_name: "Rental", foreign_key: "rental_id"
  has_many   :reservations, class_name: "Reservation", foreign_key: "rental_item_id"
end