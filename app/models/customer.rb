# add more validations!!

class Customer < ActiveRecord::Base
  validates :first_name,    length: { minimum: 1, message: "can't be blank" }
  validates :last_name,     length: { minimum: 1, message: "can't be blank" }
  validates :address1,      length: { minimum: 1, message: "can't be blank" }
  validates :city,          length: { minimum: 1, message: "can't be blank" }
  validates :state,         length: { is: 2 }
  validates :zipcode,       format: { with: /\A\d{5}\z/, message: "should be 5 digits" }
  validates :phone1,        length: { is: 12 }
  validates :phone1,        format: { with: /\d{3}-\d{3}-\d{4}/, message: "bad format" }
  validates :phone2,        length: { is: 12 }, allow_blank: true 
        
  validates :email,         format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
#   validates :cc_type,       presence: true
#   validates :cc_number1,    length: { minimum: 4, message: "can't be blank" }
#   validates :cc_number2,    length: { minimum: 4, message: "can't be blank" }
#   validates :cc_number3,    length: { minimum: 4, message: "can't be blank" }
#   validates :cc_number4,    length: { minimum: 4, message: "can't be blank" }
# 
#   validates :cc_expiry_month, presence: true
#   validates :cc_expiry_year,  presence: true
#   validates :cardholder_name, presence: true

  has_many :reservations, class_name: "Reservation", foreign_key: "customer_id"

# Method calls: Customer.find(1).reservations  
  
end
