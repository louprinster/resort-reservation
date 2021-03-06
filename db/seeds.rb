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

Admin.create! username: "tom", password: "123", password_confirmation: "123"
Admin.create! username: "deb", password: "234", password_confirmation: "234"

if RentalType.count == 0
RentalType.create! \
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
      height:         nil,
      weekday_rate:   100.0,
      weekend_rate:   150.0,
      monthly_rate:   nil
      
RentalType.create! \
      category:           "Cabin",
      subcategory:        "Land",
      max_occupancy:  6,
      description:    "Two bedroom land cabins are equipped with a fireplace, cable TV, full kitchen, washer/dryer, air conditioning. It sleeps 6 adults comfortably. Fully furnished and stocked with cookware and utensils.",
      image_filename: "2bdrmlandcabin.jpg",
      image_alt:      "Nickajack 2 Bdrm Land Cabin",
      num_bedrooms:   2,
      num_baths:      1,
      length:         nil,
      width:          nil,
      height:         nil,
      weekday_rate:   200.0,
      weekend_rate:   250.0,
      monthly_rate:   nil
      
RentalType.create! \
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
      height:         nil,
      weekday_rate:   300.0,
      weekend_rate:   350.0,
      monthly_rate:   nil

RentalType.create! \
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
      height:         nil,
      weekday_rate:   100.0,
      weekend_rate:   150.0,
      monthly_rate:   nil
      
RentalType.create! \
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
      height:         nil,
      weekday_rate:   200.0,
      weekend_rate:   250.0,
      monthly_rate:   nil
      
RentalType.create! \
      category:           "Boat",
      subcategory:        "Deck",
      max_occupancy:  6,
      description:    "Take the entire gang out for some celebratory festivities, or simply bring rod and reel for your 
           chance to lure in some catches of the day. The plush, cushioned seating surrounding the deck, 
           the tall canopy top to keep out the sun, and the roaring engine are just a few amenities that 
           come with our deck boat rentals.",
      image_filename: "deckboat.jpg",
      image_alt:      "Deck Boat Rental",
      num_bedrooms:   nil,
      num_baths:      nil,
      length:         nil,
      width:          nil,
      height:         nil,
      weekday_rate:   325.0,
      weekend_rate:   350.0,
      monthly_rate:   nil

RentalType.create! \
      category:           "Boat",
      subcategory:        "Pontoon",
      max_occupancy:  10,
      description:    "Our pontoon boat rentals allow everyone on board to enjoy the sun, waves and fresh air. 
          A pontoon boat is the perfect way to explore the lake on a lazy day or to tube or water 
          ski behind for a high-speed, adrenaline-racing adventure!  The 24-foot Leisure Kraft 
          has room for 10 people, an awning and a 115 hp, 4-stroke engine.",
      image_filename: "pontoon.jpg",
      image_alt:      "Pontoon Boat Rental",
      num_bedrooms:   nil,
      num_baths:      nil,
      length:         nil,
      width:          nil,
      height:         nil,
      weekday_rate:   225.0,
      weekend_rate:   250.0,
      monthly_rate:   nil

RentalType.create! \
      category:           "Boat",
      subcategory:        "Double Decker Pontoon",
      max_occupancy:  14,
      description:    "Our pontoon boat rentals allow everyone on board to enjoy the sun, waves and fresh air. 
          A pontoon boat is the perfect way to explore the lake on a lazy day or to tube or water 
          ski behind for a high-speed, adrenaline-racing adventure! The double-decker pontoon boat rental can hold up to 14 people and also 
          includes an AM/FM/CD player, ski tow bar, and life jackets.",
      image_filename: "dbldeckerpontoon.jpg",
      image_alt:      "Double Decker Pontoon Boat Rental",
      num_bedrooms:   nil,
      num_baths:      nil,
      length:         nil,
      width:          nil,
      height:         nil,
      weekday_rate:   300.0,
      weekend_rate:   325.0,
      monthly_rate:   nil



RentalType.create! \
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
      height:         15,
      weekday_rate:   nil,
      weekend_rate:   nil,
      monthly_rate:   200.0

RentalType.create! \
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
      height:         20,
      weekday_rate:   nil,
      weekend_rate:   nil,
      monthly_rate:   400.0

RentalType.create! \
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
      height:         30,
      weekday_rate:   nil,
      weekend_rate:   nil,
      monthly_rate:   700.0
else
  puts "Already created rentals"
end

if RentalItem.count == 0 
RentalItem.create! \
      rental_type_id:      1,
      name:           "1",
      bed_config:      "1 Queen, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_type_id:      1,
      name:           "2",
      bed_config:      "1 Queen, 1 sleeper sofa.",
      status:         "active"
RentalItem.create! \
      rental_type_id:      1,
      name:           "3",
      bed_config:      "1 Queen, 1 sleeper sofa.",
      status:         "active"
RentalItem.create! \
      rental_type_id:      1,
      name:           "4",
      bed_config:      "1 Queen, 1 sleeper sofa.",
      status:         "active"
RentalItem.create! \
      rental_type_id:      1,
      name:           "5",
      bed_config:      "1 Queen, 1 sleeper sofa.",
      status:         "inactive"

RentalItem.create! \
      rental_type_id:      3,
      name:           "6",
      bed_config:      "1 King, 1 queen, 2 twins, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_type_id:      3,
      name:           "7",
      bed_config:      "1 King, 1 queen, 2 twins, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_type_id:      3,
      name:           "8",
      bed_config:      "1 King, 1 queen, 2 twins, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_type_id:      3,
      name:           "9",
      bed_config:      "1 King, 1 queen, 2 twins, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_type_id:      3,
      name:           "10",
      bed_config:      "1 King, 1 queen, 2 twins, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_type_id:      2,
      name:           "11",
      bed_config:      "1 queen, 2 twins, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_type_id:      2,
      name:           "12",
      bed_config:      "1 queen, 2 twins, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_type_id:      4,
      name:           "13",
      bed_config:      "1 queen, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_type_id:      4,
      name:           "14",
      bed_config:      "1 queen, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_type_id:      5,
      name:           "15",
      bed_config:      "1 king, 2 twins, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_type_id:      5,
      name:           "16",
      bed_config:      "1 king, 2 twins, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_type_id:      6,
      name:           "17",
      bed_config:      "1 king, 1 queen, 2 twins, 1 sleeper sofa.",
      status:         "active"

RentalItem.create! \
      rental_type_id:      6,
      name:           "18",
      bed_config:      "1 king, 1 queen, 2 twins, 1 sleeper sofa.",
      status:         "active"


RentalItem.create! \
      rental_type_id:      7,
      name:           "2",
      bed_config:      nil,
      status:         "active"

RentalItem.create! \
      rental_type_id:      7,
      name:           "3",
      bed_config:      nil,
      status:         "active"

RentalItem.create! \
      rental_type_id:      8,
      name:           "4",
      bed_config:      nil,
      status:         "active"

 RentalItem.create! \
      rental_type_id:      8,
      name:           "5",
      bed_config:      nil,
      status:         "active"

 RentalItem.create! \
      rental_type_id:      9,
      name:           "15",
      bed_config:      nil,
      status:         "active"
else
  puts "Already created rental items"
end

if Reservation.count == 0
Reservation.create! \
      confirmation_num: 11111111,
      customer_id:    1,
      status:         "confirmed"

Reservation.create! \
      confirmation_num: 22222222,
      customer_id:    1,
      status:         "confirmed"
else
  puts "Already created reservations"
end

if ReservationItem.count == 0
ReservationItem.create! \
      category:       "Cabin",
      subcategory:    "Land",
      start_date:     Date.new(2014, 06, 06),
      end_date:       Date.new(2014, 06, 20),
      num_of_days:    14,
      adults:         2,
      children:       0,
      pets:           0,
      ave_rate:       114.21,
      subtotal:       1600.0,
      tax:            276.0,
      total:          1876.0,
      rental_item_id: 1,
      reservation_id: 1,
      status:         "confirmed"

ReservationItem.create! \
      category:       "Boat",
      subcategory:    "Deck",
      start_date:     Date.new(2014, 06, 07),
      end_date:       Date.new(2014, 06, 9),
      num_of_days:    2,
      adults:         2,
      children:       0,
      pets:           0,
      ave_rate:       337.5,
      subtotal:       675.0,
      tax:            116.44,
      total:          791.44,
      rental_item_id: 17,
      reservation_id: 1,
      status:         "confirmed"


ReservationItem.create! \
      category:       "Cabin",
      start_date:     Date.new(2014, 07, 16),
      end_date:       Date.new(2014, 07, 21),
      num_of_days:    5,
      adults:         2,
      children:       4,
      pets:           0,
      ave_rate:       220.0,
      subtotal:       1100.0,
      tax:            189.75,
      total:          1289.75,
      rental_item_id: 15,
      reservation_id: 2,
      status:         "confirmed"
            
else
  puts "Already created reservation items"
end

if Rate.count == 0
Rate.create! \
      reservation_item_id: 1,
      date:     Date.new(2014, 06, 06),
      amount:   150.0
Rate.create! \
      reservation_item_id: 1,
      date:     Date.new(2014, 06, 07),
      amount:   150.0
Rate.create! \
      reservation_item_id: 1,
      date:     Date.new(2014, 06, 8),
      amount:   100.0
Rate.create! \
      reservation_item_id: 1,
      date:     Date.new(2014, 06, 9),
      amount:   100.0
Rate.create! \
      reservation_item_id: 2,
      date:     Date.new(2014, 06, 10),
      amount:   100.0
Rate.create! \
      reservation_item_id: 1,
      date:     Date.new(2014, 06, 11),
      amount:   100.0
Rate.create! \
      reservation_item_id: 1,
      date:     Date.new(2014, 06, 12),
      amount:   100.0
Rate.create! \
      reservation_item_id: 1,
      date:     Date.new(2014, 06, 13),
      amount:   150.0
Rate.create! \
      reservation_item_id: 1,
      date:     Date.new(2014, 06, 14),
      amount:   150.0
Rate.create! \
      reservation_item_id: 2,
      date:     Date.new(2014, 06, 15),
      amount:   100.0
Rate.create! \
      reservation_item_id: 1,
      date:     Date.new(2014, 06, 16),
      amount:   100.0
Rate.create! \
      reservation_item_id: 1,
      date:     Date.new(2014, 06, 17),
      amount:   100.0
Rate.create! \
      reservation_item_id: 1,
      date:     Date.new(2014, 06, 18),
      amount:   100.0
Rate.create! \
      reservation_item_id: 1,
      date:     Date.new(2014, 06, 19),
      amount:   100.0
Rate.create! \
      reservation_item_id: 2,
      date:     Date.new(2014, 06, 07),
      amount:   350.0
Rate.create! \
      reservation_item_id: 2,
      date:     Date.new(2014, 06, 8),
      amount:   325.0

else 
  puts "Already created rates"
end


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
      phone1:     "123-123-1234",
      phone2:     nil,
      email:      "louprinster+1@gmail.com"
      
Customer.create! \
      title:      "Mr.",
      first_name: "Joe",
      last_name:  "Smith",
      address1:   "555 Maple St.",
      address2:   nil,
      city:       "Pasadena",
      state:      "CA",
      zipcode:    "91107",
      phone1:     "123-123-1234",
      phone2:     nil,
      email:      "louprinster+2@gmail.com"      
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