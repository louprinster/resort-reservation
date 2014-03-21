# add more validations!!

class Customer < ActiveRecord::Base
  validates :first_name,    length: { minimum: 1, message: "can't be blank" }
  validates :last_name,     length: { minimum: 1, message: "can't be blank" }
  validates :address1,      length: { minimum: 1, message: "can't be blank" }
  validates :city,          length: { minimum: 1, message: "can't be blank" }
  validates :state,         length: { is: 2 }
  validates :zipcode,       format: { with: /\A\d{5}\z/, message: "should be 5 digits" }
  validates :phone1,        length: { is: 10 }
#   validates :phone2,        length: { is: 10 }, allow_nil: true       
  validates :email,         presence: true
  has_many :reservations, class_name: "Reservation", foreign_key: "customer_id"
end
