class Reservation < ActiveRecord::Base
  belongs_to :rental_item, class_name: "RentalItem", foreign_key: "rental_item_id"
  belongs_to :customer, class_name: "Customer", foreign_key: "customer_id"
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate  :end_must_be_after_start_date
  
  def end_must_be_after_start_date
    errors.add(:end_date, "must be after start date") unless
      self.start_date < self.end_date
  end
end