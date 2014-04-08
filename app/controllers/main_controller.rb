class MainController < ApplicationController

def rental_type_search 

  total_guests = @reservation_item.adults + @reservation_item.children
    
  max_occupancy = @rental_types.order(:max_occupancy).last.max_occupancy  
  
  if total_guests > max_occupancy
    flash.now[:info] = 
      "Capacity of our largest #{@reservation_subcategory} #{@reservation_category} 
          is #{max_occupancy}."
    @available_rental_types = {}
    
  else 
#     rental_types = RentalType.where(category: @reservation_category, subcategory: @reservation_subcategory)
    @rental_types = @rental_types.where("max_occupancy >= ?", total_guests)
    
    @available_rental_types = {}
    
    @rental_types.each do |rental_type|
        
      available_rental_item_ids = []
      
      rental_type.rental_items.each do |rental_item|
      
        available = true
        
          rental_item.reservation_items.each do |ri|
          
            if (@reservation_item.start_date < ri.end_date and ri.start_date < @reservation_item.end_date)
              if ri.status == "confirmed"
                available = false
              end
            end
            
          end #reservation_items loop
          
        if available == true
          available_rental_item_ids << rental_item.id
        end
        
      end #rental_items loop
      
      if available_rental_item_ids.length != 0
        @available_rental_types[rental_type] = available_rental_item_ids
      end
      
    end #rental_types loop
  end #if
  
  return @available_rental_types
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
  
  session[:reservation_category] = @reservation_category
  
  @reservation_item = ReservationItem.new
  @reservation_item.start_date = Date.today
  @reservation_item.end_date   = Date.today.advance(days: 2)
  @reservation_item.adults     = 1
  @reservation_item.children   = 0
  @reservation_item.pets       = 0
  
  render :reservation_intro and return
end

def intro_post

  @reservation_category = session[:reservation_category]
  
  @reservation_item = ReservationItem.new
  @reservation_item.start_date     = params["start_date"]
  @reservation_item.end_date       = params["end_date"]
  @reservation_item.adults         = params["adults"].to_i
  @reservation_item.children       = params["children"].to_i
  @reservation_item.pets           = params["pets"].to_i

  if params["commit"] == "Check Availability"
    if params["reservation_subcategory"] == nil
      flash.now[:error] = "Please choose a #{@reservation_category} type"
      render :reservation_intro and return
    else
      session[:reservation_subcategory] = params["reservation_subcategory"].capitalize
      @reservation_subcategory = params["reservation_subcategory"].capitalize
    
      @reservation_item.rental_item_id = nil
      @reservation_item.status         = "in progress"

      if @reservation_item.save 
        if session[:reservation_id] == nil
          @reservation = Reservation.new
          @reservation.status = "in progress"
          @reservation.save!
          @reservation_item.reservation_id = @reservation.id
          session[:reservation_id]      = @reservation.id
        else
          @reservation_item.reservation_id = session[:reservation_id]
        end
        @reservation_item.save!
        session[:reservation_item_id] = @reservation_item.id
        redirect_to "/your_reservation" and return
      else
        render :reservation_intro and return
      end
    end
  elsif params["commit"] == "Continue to Guest Details"
    redirect "/guest_details" and return
  end
end

#================================================================================

def reservation_get

    @reservation_category     = session[:reservation_category]
    @reservation_subcategory  = session[:reservation_subcategory]

    @reservation_item = ReservationItem.find(session[:reservation_item_id])
    
    @rental_types = RentalType.where(category: @reservation_category, subcategory: @reservation_subcategory)
   
    @available_rental_types = rental_type_search
    
    if @available_rental_types == {}
      flash.now[:info] = "No #{@reservation_subcategory} #{@reservation_category}s are available for this date range or occupancy."
    end
        
    render :your_reservation and return

end

def reservation_post
  
  @reservation_item = ReservationItem.find(session[:reservation_item_id])
  
  if params["commit"] == "Cancel"  
#     @reservation_item.reservation.destroy!
    @reservation_item.destroy!
    redirect_to "/" and return
    
  elsif params["commit"] == "Check Availability"
#     lines 148-156 are the same as intro_post ??
    @reservation_category    = session[:reservation_category]
    @reservation_subcategory          = params["reservation_subcategory"]
    session[:reservation_subcategory] = params["reservation_subcategory"]  
          
    @reservation_item.start_date     = params["start_date"]
    @reservation_item.end_date       = params["end_date"]
    @reservation_item.adults         = params["adults"].to_i
    @reservation_item.children       = params["children"].to_i
    @reservation_item.pets           = params["pets"].to_i
    
    if @reservation_item.save
        @rental_types = RentalType.where(category: @reservation_category, subcategory: @reservation_subcategory)
        @available_rental_types = rental_type_search
        if @available_rental_types == {}
          flash.now[:info] = "No #{@reservation_subcategory} #{@reservation_category}s are available for this date range or occupancy."
        end
    end
    
    render :your_reservation and return
                      
  elsif params["rental_item_id"] != nil

    @reservation_item.rental_item_id = params["rental_item_id"]
    @reservation_item.save!
    
    session[:rental_item_id] = params["rental_item_id"]

    redirect_to "/add_reservation_item" and return
  end
  
end
#==============================================================================

def add_reservation_item_get

  @reservation_items = Reservation.find(session[:reservation_id]).reservation_items
  
  render :add_reservation_item and return

end

def add_reservation_item_post

  if params["change_res_item_id"] != nil
    res_item_id = params["cancel_res_item_id"]
    reservation_item = ReservationItem.find(res_item_id)
    session[:reservation_category] = reservation_item.rental_item.rental_type.category
    session[:reservation_subcategory] = reservation_item.rental_item.rental_type.subcategory
    session[:reservation_item_id] = res_item_id
    redirect_to "/your_reservation" and return
    
  elsif params["cancel_res_item_id"] != nil
    res_item_id = params["cancel_res_item_id"]
    ReservationItem.find(res_item_id).destroy!
    @reservation_items = Reservation.find(session[:reservation_id]).reservation_items
    if @reservation_items.count > 0
      flash[:info] = "Reservation item cancelled"
      redirect_to "/add_reservation_item" and return
    else 
      Reservation.find(session[:reservation_id]).destroy!
      flash[:info] = "Your reservation has been cancelled."
      redirect_to "/" and return
    end
    
  elsif params["commit"] == "Add a cabin reservation"
    @reservation_category = "Cabin"
    session[:reservation_category] = "Cabin"
    session[:reservation_subcategory] = nil
    flash[:info] = "Add a cabin to your existing reservation"
    redirect_to "/cabin/intro" and return
    
  elsif params["commit"] == "Add a boat reservation"
    @reservation_category = "Boat"
    session[:reservation_category] = "Boat"
    session[:reservation_subcategory] = nil
    flash[:info] = "Add a boat to your existing reservation"
    redirect_to "/boat/intro" and return
    
  elsif params["commit"] == "Continue"
    redirect_to "/guest_details" and return
  end

end

#===============================================================================

def guest_details_get

  @reservation_items = Reservation.find(session[:reservation_id]).reservation_items
  @u_s_states  = USState.order(:name).all
  
  if session[:customer_id] != nil 
    @customer = Customer.find(session[:customer_id])
  else
    @customer = Customer.new
  end

  render :guest_details and return

end

def guest_details_post
# NOTE:  lines 259-278 are a copy of first two conditions in add_reservation_item_post
  if params["change_res_item_id"] != nil
    res_item_id = params["cancel_res_item_id"]
    reservation_item = ReservationItem.find(res_item_id)
    session[:reservation_category] = reservation_item.rental_item.rental_type.category
    session[:reservation_subcategory] = reservation_item.rental_item.rental_type.subcategory
    session[:reservation_item_id] = res_item_id
    redirect_to "/your_reservation" and return
    
  elsif params["cancel_res_item_id"] != nil
    res_item_id = params["cancel_res_item_id"]
    ReservationItem.find(res_item_id).destroy!
    @reservation_items = Reservation.find(session[:reservation_id]).reservation_items
    if @reservation_items.count > 0
      flash[:info] = "Reservation item cancelled"
      redirect_to "/add_reservation_item" and return
    else 
      Reservation.find(session[:reservation_id]).destroy!
      flash[:info] = "Your reservation has been cancelled."
      redirect_to "/" and return
    end
    
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
        @reservation_items = Reservation.find(session[:reservation_id]).reservation_items
        @u_s_states  = USState.order(:name).all
        render :guest_details and return
      end
  end
  
end

#===============================================================================

def review_get
  
  @reservation_items = Reservation.find(session[:reservation_id]).reservation_items
  @customer    = Customer.find(session[:customer_id])  
  render :review and return
end

def review_post

# NOTE:  lines 315-334 are a copy of first two conditions in add_reservation_item_post
  if params["change_res_item_id"] != nil
    res_item_id = params["change_res_item_id"]
    reservation_item = ReservationItem.find(res_item_id)
    session[:reservation_category] = reservation_item.rental_item.rental_type.category
    session[:reservation_subcategory] = reservation_item.rental_item.rental_type.subcategory
    session[:reservation_item_id] = res_item_id
    redirect_to "/your_reservation" and return
    
  elsif params["cancel_res_item_id"] != nil
    res_item_id = params["cancel_res_item_id"]
    ReservationItem.find(res_item_id).destroy!
    @reservation_items = Reservation.find(session[:reservation_id]).reservation_items
    if @reservation_items.count > 0
      flash[:info] = "Reservation item cancelled"
      redirect_to "/add_reservation_item" and return
    else 
      Reservation.find(session[:reservation_id]).destroy!
      flash[:info] = "Your reservation has been cancelled."
      redirect_to "/" and return
    end
    
  elsif params["commit"] == "Change Guest Details"
    redirect_to "/guest_details" and return
    
  elsif params["commit"] == "Confirm"
    reservation = Reservation.find(session[:reservation_id])
    reservation.status = "confirmed"
    reservation.customer_id = session[:customer_id]
    reservation.save!
    @reservation_items = reservation.reservation_items
    @reservation_items.each do |res_item|
      res_item.status = "confirmed"
      res_item.save!
    end
    flash[:success] = "Your cabin reservation has been confirmed."
    session.clear
    redirect_to "/" and return
  end
  
end

def contact
end

end # class MainController
