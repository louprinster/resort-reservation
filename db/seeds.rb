# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rental.count == 0
Rental.create! \
      category:           "Cabin",
      subcategory:        "Land",
      max_occupancy:  4,
      description:    "One bedroom land cabins have a fireplace, cable TV, full kitchen, washer/dryer, air conditioning. It sleeps 4 adults comfortably. Fully furnished and stocked with cookware and utensils.",
      image_filename: "1bdrmlandcabin.jpg",
      image_alt:      "Nickajack 1 Bdrm Land Cabin",
      num_bedrooms:   1,
      num_baths:      1,
      length:         nil,
      width:          nil,
      height:         nil
      
Rental.create! \
      category:           "Cabin",
      subcategory:        "Land",
      max_occupancy:  6,
      description:    "Some one bedroom land cabins have a loft with 2 twin beds. They are equipped with a fireplace, cable TV, full kitchen, washer/dryer, air conditioning. It sleeps 6 adults comfortably. Fully furnished and stocked with cookware and utensils.",
      image_filename: "1bdrmlandcabin.jpg",
      image_alt:      "Nickajack 1 Bdrm Land Cabin with Loft",
      num_bedrooms:   1,
      num_baths:      1,
      length:         nil,
      width:          nil,
      height:         nil
      
Rental.create! \
      category:           "Cabin",
      subcategory:        "Land",
      max_occupancy:  10,
      description:    "Three bedroom land cabins have a fireplace, cable TV, full kitchen, washer/dryer, air conditioning. It sleeps 10 adults comfortably. Fully furnished and stocked with cookware and utensils.",
      image_filename: "3bdrmlandcabin.jpg",
      image_alt:      "Nickajack 3 Bdrm Land Cabin",
      num_bedrooms:   3,
      num_baths:      2,
      length:         nil,
      width:          nil,
      height:         nil

Rental.create! \
      category:           "Cabin",
      subcategory:        "Floating",
      max_occupancy:  4,
      description:    "One bedroom floating cabins have a fireplace, cable TV, full kitchen, washer/dryer, air conditioning. They sleeps 4 adults comfortably. Fully furnished and stocked with cookware and utensils.",
      image_filename: "1bdrmfloatingcabin.jpg",
      image_alt:      "Nickajack 1 Bdrm Land Cabin",
      num_bedrooms:   1,
      num_baths:      1,
      length:         nil,
      width:          nil,
      height:         nil
      
Rental.create! \
      category:           "Cabin",
      subcategory:        "Floating",
      max_occupancy:  6,
      description:    "Two bedroom floating cabins are equipped with a fireplace, cable TV, full kitchen, washer/dryer, air conditioning. It sleeps 6 adults comfortably. Fully furnished and stocked with cookware and utensils.",
      image_filename: "2bdrmfloatingcabin.jpg",
      image_alt:      "Nickajack 1 Bdrm Land Cabin with Loft",
      num_bedrooms:   2,
      num_baths:      1,
      length:         nil,
      width:          nil,
      height:         nil
      
Rental.create! \
      category:           "Boat",
      subcategory:        "Deck",
      max_occupancy:  6,
      description:    "Deck boat description here...",
      image_filename: "deckboat.jpg",
      image_alt:      "Deck Boat Rental",
      num_bedrooms:   nil,
      num_baths:      nil,
      length:         nil,
      width:          nil,
      height:         nil

Rental.create! \
      category:           "Boat",
      subcategory:        "Pontoon",
      max_occupancy:  10,
      description:    "Pontoon boat description here...",
      image_filename: "pontoon.jpg",
      image_alt:      "Pontoon Boat Rental",
      num_bedrooms:   nil,
      num_baths:      nil,
      length:         nil,
      width:          nil,
      height:         nil

Rental.create! \
      category:           "Boat",
      subcategory:        "Double Decker Pontoon",
      max_occupancy:  14,
      description:    "Double Decker Pontoon boat description here...",
      image_filename: "dbldeckerpontoon.jpg",
      image_alt:      "Double Decker Pontoon Boat Rental",
      num_bedrooms:   nil,
      num_baths:      nil,
      length:         nil,
      width:          nil,
      height:         nil



Rental.create! \
      category:           "Boat Slip",
      subcategory:        "Covered",
      max_occupancy:  30,
      description:    "Boat slip description here...",
      image_filename: "",
      image_alt:      "Nickajack Boat Slip Rental",
      num_bedrooms:   nil,
      num_baths:      nil,
      length:         30,
      width:          12,
      height:         15

Rental.create! \
      category:           "Boat Slip",
      subcategory:        "Covered",
      max_occupancy:  50,
      description:    "Boat slip description here...",
      image_filename: "",
      image_alt:      "Nickajack Boat Slip Rental",
      num_bedrooms:   nil,
      num_baths:      nil,
      length:         50,
      width:          18,
      height:         20

Rental.create! \
      category:           "Boat Slip",
      subcategory:        "Uncovered",
      max_occupancy:  80,
      description:    "Uncovered Boat slip description here...",
      image_filename: "",
      image_alt:      "Nickajack Boat Slip Rental",
      num_bedrooms:   nil,
      num_baths:      nil,
      length:         80,
      width:          20,
      height:         30
else
  puts "Already created rentals"
end

if RentalItem.count == 0 
RentalItem.create! \
      rental_id:      1,
      name:           "1",
      bed_config:      "1 Queen, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_id:      1,
      name:           "2",
      bed_config:      "1 Queen, 1 sleeper sofa.",
      status:         "active"
RentalItem.create! \
      rental_id:      1,
      name:           "3",
      bed_config:      "1 Queen, 1 sleeper sofa.",
      status:         "active"
RentalItem.create! \
      rental_id:      1,
      name:           "4",
      bed_config:      "1 Queen, 1 sleeper sofa.",
      status:         "active"
RentalItem.create! \
      rental_id:      1,
      name:           "5",
      bed_config:      "1 Queen, 1 sleeper sofa.",
      status:         "inactive"

RentalItem.create! \
      rental_id:      3,
      name:           "6",
      bed_config:      "1 King, 1 queen, 2 twins, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_id:      3,
      name:           "7",
      bed_config:      "1 King, 1 queen, 2 twins, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_id:      3,
      name:           "8",
      bed_config:      "1 King, 1 queen, 2 twins, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_id:      3,
      name:           "9",
      bed_config:      "1 King, 1 queen, 2 twins, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_id:      3,
      name:           "10",
      bed_config:      "1 King, 1 queen, 2 twins, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_id:      2,
      name:           "11",
      bed_config:      "1 queen, 2 twins, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_id:      2,
      name:           "12",
      bed_config:      "1 queen, 2 twins, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_id:      4,
      name:           "13",
      bed_config:      "1 queen, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_id:      4,
      name:           "14",
      bed_config:      "1 queen, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_id:      5,
      name:           "15",
      bed_config:      "1 king, 2 twins, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_id:      5,
      name:           "16",
      bed_config:      "1 king, 2 twins, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_id:      6,
      name:           "17",
      bed_config:      "1 king, 1 queen, 2 twins, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_id:      6,
      name:           "18",
      bed_config:      "1 king, 1 queen, 2 twins, 1 sleeper sofa.",
      status:         "active"


RentalItem.create! \
      rental_id:      7,
      name:           "Deck Boat 2",
      bed_config:      nil,
      status:         "active"

RentalItem.create! \
      rental_id:      7,
      name:           "Deck Boat 3",
      bed_config:      nil,
      status:         "active"

RentalItem.create! \
      rental_id:      8,
      name:           "Pontoon 4",
      bed_config:      nil,
      status:         "active"

 RentalItem.create! \
      rental_id:      8,
      name:           "Pontoon 5",
      bed_config:      nil,
      status:         "active"

 RentalItem.create! \
      rental_id:      9,
      name:           "Double Decker Pontoon",
      bed_config:      nil,
      status:         "active"
else
  puts "Already created rental items"
end

# if Reservation.count == 0
# Reservation.create! \
#       start_date:     "2014-05-01",
#       end_date:       "2014,05,05",
#       adults:         2,
#       children:       2,
#       pets:           1,
#       tax:            0.1,
#       rental_item_id: 1,
#       customer_id:    1,
#       status:         "confirmed"
# 
# Reservation.create! \
#       start_date:     "2014-05-10",
#       end_date:       "2014-05-14",
#       adults:         2,
#       children:       2,
#       pets:           1,
#       tax:            0.1,
#       rental_item_id: 1,
#       customer_id:    1,
#       status:         "confirmed"
#             
# else
#   puts "Already created reservations"
# end

if Customer.count == 0
Customer.create! \
      title:      "Ms.",
      first_name: "Sue",
      last_name:  "Blue",
      address1:   "123 Elm St.",
      address2:   nil,
      city:       "Pasadena",
      state:      "CA",
      zipcode:    "91107",
      phone1:     "1231231234",
      phone2:     nil,
      email:      "sueblue@gmail.com"
else
  puts "Already created customer"
end
     

if USState.count == 0
  USState.create(name: "Alabama", abbreviation: "AL")
  USState.create(name: "Alaska", abbreviation: "AK")
  USState.create(name: "Arizona", abbreviation:"AZ")
  USState.create(name: "Arkansas", abbreviation: "AR")
  USState.create(name: "California", abbreviation: "CA")
  USState.create(name: "Colorado", abbreviation: "CO")
  USState.create(name: "Connecticut", abbreviation:"CT")
  USState.create(name: "Delaware", abbreviation: "DE")
  USState.create(name: "Florida", abbreviation:"FL")
  USState.create(name: "Georgia", abbreviation:"GA")
  USState.create(name: "Hawaii", abbreviation: "HI")
  USState.create(name: "Idaho", abbreviation:"ID")
  USState.create(name: "Illinois", abbreviation: "IL")
  USState.create(name: "Indiana", abbreviation:"IN")
  USState.create(name: "Iowa", abbreviation: "IA")
  USState.create(name: "Kansas", abbreviation: "KS")
  USState.create(name: "Kentucky", abbreviation: "KY")
  USState.create(name: "Louisiana", abbreviation:"LA")
  USState.create(name: "Maine", abbreviation:"ME")
  USState.create(name: "Maryland", abbreviation: "MD")
  USState.create(name: "Massachusetts", abbreviation:"MA")
  USState.create(name: "Michigan", abbreviation: "MI")
  USState.create(name: "Minnesota", abbreviation:"MN")
  USState.create(name: "Mississippi", abbreviation:"MS")
  USState.create(name: "Missouri", abbreviation: "MO")
  USState.create(name: "Montana", abbreviation:"MT")
  USState.create(name: "Nebraska", abbreviation: "NE")
  USState.create(name: "Nevada", abbreviation: "NV")
  USState.create(name: "New Hampshire", abbreviation:"NH")
  USState.create(name: "New Jersey", abbreviation:"NJ")
  USState.create(name: "New Mexico", abbreviation:"NM")
  USState.create(name: "New York", abbreviation:"NY")
  USState.create(name: "North Carolina", abbreviation:"NC")
  USState.create(name: "North Dakota", abbreviation:"ND")
  USState.create(name: "Ohio", abbreviation: "OH")
  USState.create(name: "Oklahoma", abbreviation: "OK")
  USState.create(name: "Oregon", abbreviation: "OR")
  USState.create(name: "Pennsylvania", abbreviation: "PA")
  USState.create(name: "Rhode Island", abbreviation:"RI")
  USState.create(name: "South Carolina", abbreviation:"SC")
  USState.create(name: "South Dakota", abbreviation:"SD")
  USState.create(name: "Tennessee", abbreviation:"TN")
  USState.create(name: "Texas", abbreviation:"TX")
  USState.create(name: "Utah", abbreviation: "UT")
  USState.create(name: "Vermont", abbreviation:"VT")
  USState.create(name: "Virginia", abbreviation: "VA")
  USState.create(name: "Washington", abbreviation: "WA")
  USState.create(name: "West Virginia", abbreviation:"WV")
  USState.create(name: "Wisconsin", abbreviation:"WI")
  USState.create(name: "Wyoming", abbreviation:"WY")
  USState.create(name: "District of Columbia", abbreviation: "DC")
else
  puts "Already created states"
end