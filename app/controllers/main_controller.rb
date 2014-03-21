class MainController < ApplicationController


def rental_search 
  total_guests = @adults + @children  
  max_occupancy = Rental.where(category: @reservation_category, 
                            subcategory: @reservation_subcategory).order(:max_occupancy).last.max_occupancy  
  
  if total_guests > max_occupancy
    flash.now[:info] = 
      "Capacity of our largest #{@reservation_subcategory} #{@reservation_category} is #{max_occupancy}."
    @available_rentals = {}
  else 
    rentals = Rental.where(category: @reservation_category, subcategory: @reservation_subcategory)
    rentals = rentals.where("max_occupancy >= ?", total_guests)
    @available_rentals = {}
    
    rentals.each do |rental|    
      available_rental_item_ids = []
      rental.rental_items.each do |rental_item|
        available = true
          rental_item.reservations.each do |res|
            if (@start_date < res.end_date.to_s and res.start_date.to_s < @end_date)
              available = false
            end
          end #reservations loop
        if available == true
          available_rental_item_ids << rental_item.id
        end
      end #rental_items loop
      if available_rental_item_ids.length != 0
        @available_rentals[rental] = available_rental_item_ids
      end
    end #rentals loop
  end #if
  return @available_rentals
end


def root
  render :index and return
end

def intro_get
  if params["reservation_category"] == "boat_slip"
    @reservation_category = "Boat Slip"
  else
    @reservation_category = params["reservation_category"].capitalize
  end
  @reservation = Reservation.new
  @reservation_subcategory = nil
  @start_date = Date.today
  @end_date = Date.today.advance(days: 2)
  @adults     = 1
  @children   = 0
  @pets       = 0
  render :reservation_intro and return
end

def intro_post

  if params["reservation_category"] == "boat_slip"
      @reservation_category = "Boat Slip"
  else
      @reservation_category = params["reservation_category"].capitalize
  end

  @start_date              = params["start_date"]
  @end_date                = params["end_date"]
  @reservation_subcategory = params["reservation_subcategory"]
  @adults                  = params["adults"].to_i
  @children                = params["children"].to_i
  @pets                    = params["pets"].to_i
  @reservation = Reservation.new
  
  if (@start_date < Date.today.to_s) or (@end_date < Date.today.to_s)
    flash.now[:error] = "Please enter a valid date range."
    @start_date = Date.today
    @end_date   = Date.today.advance(days: 2)
    render :reservation_intro and return
  elsif @start_date > @end_date
    flash.now[:error] = "End date must be after start date."
    render :reservation_intro and return
  elsif params["reservation_subcategory"] == nil
    flash.now[:error] = "Please choose a #{@reservation_category} type"
    render :reservation_intro and return
  else
      session[:reservation_category]    = params["reservation_category"].capitalize #(cabin, boat or boat slip)
      session[:reservation_subcategory] = params["reservation_subcategory"].capitalize #(land, floating, deck, pontoon, covered, etc)
      session[:start_date]              = params["start_date"]
      session[:end_date]                = params["end_date"]
      session[:adults]                  = params["adults"].to_i
      session[:children]                = params["children"].to_i
      session[:pets]                    = params["pets"].to_i
      session[:customer_id]             = nil
      session[:rental_item_id]          = nil

      redirect_to "/your_reservation" and return
  end

end

def reservation_get

    @reservation_category     = session[:reservation_category]
    @reservation_subcategory  = session[:reservation_subcategory]
    @start_date               = session[:start_date]
    @end_date                 = session[:end_date]
    @adults                   = session[:adults]
    @children                 = session[:children]
    @pets                     = session[:pets]
   
    @available_rentals = rental_search
    if @available_rentals == {}
      flash.now[:info] = "No #{@reservation_subcategory} #{@reservation_category}s are available for this date range or occupancy."
    end
    
    render :your_reservation and return

end

def reservation_post

  session[:reservation_subcategory] = params["reservation_subcategory"].capitalize #(land, floating, deck, pontoon, covered, etc)
  session[:start_date]              = params["start_date"]
  session[:end_date]                = params["end_date"]
  session[:adults]                  = params["adults"].to_i
  session[:children]                = params["children"].to_i
  session[:pets]                    = params["pets"].to_i

  if params["commit"] == "Cancel"  
    session.clear
    redirect_to "/" and return
    
  elsif params["commit"] == "Check Availability"
  
        @reservation_category    = session[:reservation_category]

      # If user changed the subcategory (land, floating OR deck, pontoon, dbl pontoon), save to session and to instance var
        session[:reservation_subcategory] = params["reservation_subcategory"]  
        @reservation_subcategory          = params["reservation_subcategory"]

        @start_date          = params["start_date"]
        @end_date            = params["end_date"]
        @adults              = params["adults"].to_i
        @children            = params["children"].to_i
        @pets                = params["pets"].to_i
               
        if (@start_date < Date.today.to_s) or (@end_date < Date.today.to_s)
          flash.now[:error] = "Please enter a valid date range."
          @start_date = Date.today
          @end_date   = Date.today.advance(days: 2)
          render :reservation_intro and return
        elsif @start_date > @end_date
          flash.now[:error] = "End date must be after start date."
          render :your_reservation and return
        elsif params["reservation_subcategory"] == nil
          flash.now[:error] = "Please choose a #{@reservation_category} type"
          render :your_reservation and return        
        else 
          @reservation_subcategory = params["reservation_subcategory"]
          @available_rentals       = rental_search
          if @available_rentals == {}
            flash.now[:info] = "No #{@reservation_subcategory} #{@reservation_category}s are available for this date range or occupancy."
          end
          render :your_reservation and return
        end
            
  elsif params["rental_item_id"] != nil
# Add check here for if user changed reservation criteria, check availability again ???
    
    session[:rental_item_id] = params["rental_item_id"]
    redirect_to "/guest_details" and return
  end
  
end

def guest_details_get

  @rental_item = RentalItem.find(session[:rental_item_id])  
  @rental = Rental.find(@rental_item.rental.id)
  
  @start_date = session[:start_date]
  @end_date   = session[:end_date]
  @adults     = session[:adults]
  @children   = session[:children]
  @pets       = session[:pets]
  
  @u_s_states  = USState.order(:name).all
  
  if session[:customer_id] != nil 
    @customer = Customer.find(session[:customer_id])
  else
    @customer = Customer.new
  end

  render :guest_details and return

end

def guest_details_post

  if params["commit"] == "Change Reservation"
      redirect_to "/your_reservation" and return

  elsif params["commit"] == "Cancel"
      session.clear
      redirect_to "/" and return
    
  elsif params["commit"] == "Continue"
      @customer = Customer.new
      @customer.first_name  = params["first_name"]
      @customer.last_name   = params["last_name"]
      @customer.address1    = params["address1"]
      @customer.address2    = params["address2"]
      @customer.city        = params["city"]
      @customer.state       = params["state"]
      @customer.zipcode     = params["zipcode"]
      @customer.phone1      = params["phone1"]
      @customer.phone2      = params["phone2"]
      @customer.email       = params["email"]
      if @customer.save == true
        session[:customer_id] = @customer.id
        redirect_to "/review" and return
      else
        @rental_item = RentalItem.find(session[:rental_item_id])  
        @rental = Rental.find(@rental_item.rental.id)
        @start_date = session[:start_date]
        @end_date   = session[:end_date]
        @adults     = session[:adults]
        @children   = session[:children]
        @pets       = session[:pets]
        @u_s_states  = USState.order(:name).all
        render :guest_details and return
      end
  end
  
end

def review_get
  
  @rental_item = RentalItem.find(session[:rental_item_id])  
  @rental = Rental.find(@rental_item.rental.id)
  
  @start_date = session[:start_date]
  @end_date   = session[:end_date]
  @adults     = session[:adults]
  @children   = session[:children]
  @pets       = session[:pets]
  
  @customer    = Customer.find(session[:customer_id])  
  render :review and return
end

def review_post

  if params["commit"] == "Cancel"
    session.clear
    redirect_to "/" and return
    
  elsif params["commit"] == "Change Guest Details"
    redirect_to "/guest_details" and return
    
  elsif params["commit"] == "Change Reservation"
    redirect_to "/your_reservation" and return
    
  elsif params["commit"] == "Confirm"
    @reservation = Reservation.new
    @reservation.start_date     = session[:start_date]
    @reservation.end_date       = session[:end_date]
    @reservation.rental_item_id = session[:rental_item_id]
    @reservation.adults         = session[:adults]
    @reservation.children       = session[:children]
    @reservation.pets           = session[:pets]
    @reservation.customer_id    = session[:customer_id]
    @reservation.status = "confirmed"
    if @reservation.save
      flash[:success] = "Your cabin reservation has been confirmed."
      session.clear
      redirect_to "/" and return
    else
      render :review and return
    end
  end
  
end

end # class MainController
