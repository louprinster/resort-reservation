class ReservationItem < ActiveRecord::Base

# Left Table
  belongs_to :reservation,
                class_name: "Reservation",
                foreign_key: "reservation_id"
  
# Right Table
  belongs_to :rental_item, 
                class_name: "RentalItem", 
                foreign_key: "rental_item_id"
  
  has_many  :rates, class_name: "Rate", foreign_key: "reservation_item_id"
                
# Sample method calls:
#   ReservationItem.find(1).reservation
#   ReservationItem.find(1).rental_item
#   ReservationItem.find(1).rates
                
  validates :start_date, presence: true
  validate  :start_must_be_today_or_after
  validates :end_date, presence: true, if: :cabin?
  validate  :end_must_be_after_start_date, if: :cabin?
  
  validate  :num_of_days, presence: true, if: :boat?
  
  def cabin?
    self.category == "Cabin"
  end
  
  def boat?
    self.category == "Boat"
  end
  
  def start_must_be_today_or_after
    if self.start_date != nil && self.start_date != ""
      if self.start_date < Date.today
        errors.add(:start_date, "must be today or after")
      end
    end
  end
  
  def end_must_be_after_start_date
    if self.end_date != nil && self.end_date != "" && self.start_date != nil && self.start_date != ""
      if self.end_date <= self.start_date
        errors.add(:end_date, "must be after Check-in")
      end
    end
  end
  
end