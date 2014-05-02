class MainController < ApplicationController

before_filter do
  session[:original_route] = request.path_info
  
  @logged_in_user = User.where(id: session[:logged_in_user_id]).first
  if @logged_in_user != nil && @logged_in_user.was_email_verified != true
    flash.now[:remind_to_verify_email] = true
  end
end

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
              if ri.status == "confirmed" or ri.status == "in progress"
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
    @reservation_category = params["reservation_category"].titleize
  end
  
  session[:reservation_category] = @reservation_category
  
  @reservation_item = ReservationItem.new
  @start_date = Date.today.strftime("%a, %b %d, %Y")
  @reservation_item.adults     = 1
  @reservation_item.children   = 0
  @reservation_item.pets       = 0
  
  if @reservation_category == "Boat"
    @reservation_item.num_of_days = 1
  elsif @reservation_category == "Cabin"
    @end_date   = Date.today.advance(days: 2).strftime("%a, %b %d, %Y")
  elsif @reservation_category == "Boat Slip"
    @end_date == Date.today.advance(days: 30).strftime("%a, %b %d, %Y")
  end
  render :reservation_intro and return
end

def intro_post
  @reservation_category = session[:reservation_category]
    
  if params["reservation_subcategory"] == nil
    @reservation_item = ReservationItem.new
    @start_date = params["start_date"].to_date.strftime("%a, %b %d, %Y")
    @reservation_item.adults     = params["adults"].to_i
    @reservation_item.children   = params["children"].to_i
    @reservation_item.pets       = params["pets"].to_i
  
    if @reservation_category == "Boat"
      @reservation_item.num_of_days = 1
    elsif @reservation_category == "Cabin"
      @end_date   = params["end_date"].to_date.strftime("%a, %b %d, %Y")
    elsif @reservation_category == "Boat Slip"
      @end_date == params["end_date"].to_date.strftime("%a, %b %d, %Y")
    end    
    
    flash.now[:error] = "Please choose a #{@reservation_category} type"
    render :reservation_intro and return
    
  else
    @reservation_category = session[:reservation_category]

  
    if session[:reservation_id] == nil
      @reservation = Reservation.new
      @reservation.status = "in progress"
      @reservation.save!
      session[:reservation_id]      = @reservation.id
    else
      @reservation = Reservation.find(session[:reservation_id])
    end
    if session[:reservation_item_id] == nil    
      @reservation_item = ReservationItem.new
    else
      @reservation_item = ReservationItem.find(session[:reservation_item_id])
    end
    @reservation_item.category       = @reservation_category
    @reservation_item.subcategory    = params["reservation_subcategory"]
    @reservation_item.start_date     = params["start_date"]
    @reservation_item.adults         = params["adults"].to_i
    @reservation_item.children       = params["children"].to_i
    @reservation_item.pets           = params["pets"].to_i
    @reservation_item.end_date       = params["end_date"]
    @reservation_item.num_of_days    = params["num_of_days"].to_i
    @reservation_item.rental_item_id = nil
    @reservation_item.status         = "in progress"
    @reservation_item.reservation_id = session[:reservation_id]

    if @reservation_item.save
      if @reservation_category == "Cabin"
        @reservation_item.num_of_days  = (@reservation_item.start_date...@reservation_item.end_date).count
      elsif @reservation_category == "Boat"
        @reservation_item.end_date = @reservation_item.start_date + @reservation_item.num_of_days
      end
      @reservation_item.save!
      session[:reservation_subcategory] = @reservation_item.subcategory
      session[:reservation_item_id] = @reservation_item.id
      redirect_to "/your_reservation" and return
    else
      render :reservation_intro and return
    end
  end
  
end

#================================================================================

def reservation_get

    @reservation_category     = session[:reservation_category]
    @reservation_subcategory  = session[:reservation_subcategory]

    @reservation_item = ReservationItem.find(session[:reservation_item_id])
    @start_date = @reservation_item.start_date.strftime("%a, %b %d, %Y")
    @end_date   = @reservation_item.end_date.strftime("%a, %b %d, %Y")

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
    @res_item_id = session[:reservation_item_id]
    cancel_reservation_item
    
  elsif params["commit"] == "Check Availability"
    @reservation_category             = session[:reservation_category]
    @reservation_subcategory          = params["reservation_subcategory"]
    session[:reservation_subcategory] = params["reservation_subcategory"].titleize
          
    @reservation_item.category       = @reservation_category
    @reservation_item.start_date     = params["start_date"]
    @reservation_item.adults         = params["adults"].to_i
    @reservation_item.children       = params["children"].to_i
    @reservation_item.pets           = params["pets"].to_i
    @reservation_item.end_date       = params["end_date"]
    @reservation_item.num_of_days    = params["num_of_days"].to_i

    @start_date = @reservation_item.start_date.strftime("%a, %b %d, %Y")

    if @reservation_item.save
      if @reservation_category == "Cabin"
        @end_date   = @reservation_item.end_date.strftime("%a, %b %d, %Y")
        @reservation_item.num_of_days  = (@reservation_item.start_date...@reservation_item.end_date).count
      elsif @reservation_category == "Boat"
        @reservation_item.end_date = @reservation_item.start_date + @reservation_item.num_of_days
      end
      @reservation_item.save!
      @rental_types = RentalType.where(category: @reservation_category, subcategory: @reservation_subcategory)
      @available_rental_types = rental_type_search
      if @available_rental_types == {}
        flash.now[:info] = "No #{@reservation_subcategory} #{@reservation_category}s are available for this date range or occupancy."
      end
      render :your_reservation and return
    else
      render :your_reservation and return
    end
                      
  elsif params["rental_item_id"] != nil

    @reservation_item.rental_item_id = params["rental_item_id"]
    @reservation_item.status         = "in progress"
    @reservation_item.save!
    assign_rates
    session[:reservation_item_id] = nil
    redirect_to "/add_reservation_item" and return
  end
  
end
#==============================================================================

def add_reservation_item_get

  @reservation_items = Reservation.find(session[:reservation_id]).reservation_items
  render :add_reservation_item and return

end

def add_reservation_item_post

  if params["details_res_item_id"] != nil
    id = params["details_res_item_id"]
    @rental_type = ReservationItem.find(id).rental_item.rental_type
    render :res_item_details and return
    
  elsif params["change_res_item_id"] != nil
    @res_item_id = params["change_res_item_id"]
    change_reservation_item
    
  elsif params["cancel_res_item_id"] != nil
    @res_item_id = params["cancel_res_item_id"]
    cancel_reservation_item
    
  elsif params["commit"] == "Add a cabin reservation"
    @reservation_category = "Cabin"
    session[:reservation_category] = "Cabin"
    session[:reservation_subcategory] = nil
    session[:reservation_item_id] = nil
    flash[:info] = "Add a cabin to your existing reservation"
    redirect_to "/cabin/intro" and return
    
  elsif params["commit"] == "Add a boat reservation"
    @reservation_category = "Boat"
    session[:reservation_category] = "Boat"
    session[:reservation_subcategory] = nil
    session[:reservation_item_id] = nil
    flash[:info] = "Add a boat to your existing reservation"
    redirect_to "/boat/intro" and return
    
  elsif params["commit"] == "Continue to Guest Details"
    redirect_to "/guest_details" and return
  end

end

#===============================================================================

def guest_details_get

  @reservation_items = Reservation.find(session[:reservation_id]).reservation_items
  @u_s_states  = USState.order(:name).all
  @email = nil
  find_customer
  render :guest_details and return

end

def guest_details_post

  if params["details_res_item_id"] != nil
    id = params["details_res_item_id"]
    @rental_type = ReservationItem.find(id).rental_item.rental_type
    render :res_item_details and return
    
  elsif params["change_res_item_id"] != nil
    @res_item_id = params["change_res_item_id"]
    change_reservation_item
    
  elsif params["cancel_res_item_id"] != nil
    @res_item_id = params["cancel_res_item_id"]
    cancel_reservation_item
        
  elsif params["commit"] == "Continue to Review"
      @email = params["email"] # used to try to match against existing customer records
      find_customer
      @customer.title       = params["title"]
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

  if params["details_res_item_id"] != nil
    id = params["details_res_item_id"]
    @rental_type = ReservationItem.find(id).rental_item.rental_type
    render :res_item_details and return

  elsif params["change_res_item_id"] != nil
    @res_item_id = params["change_res_item_id"]
    change_reservation_item

  elsif params["cancel_res_item_id"] != nil
    @res_item_id = params["cancel_res_item_id"]
    cancel_reservation_item
    
  elsif params["commit"] == "Change Guest Details"
    redirect_to "/guest_details" and return
    
  elsif params["commit"] == "Confirm"
    reservation = Reservation.find(session[:reservation_id])
    if reservation.confirmation_num == nil
      reservation.confirmation_num = rand(99999999) + 1
    end
    reservation.status = "confirmed"
    reservation.customer_id = session[:customer_id]
    reservation.save!
    
    @reservation_items = reservation.reservation_items
    @reservation_items.each do |res_item|
      res_item.status = "confirmed"
      subtotal = 0
      res_item.rates.each do |rate|
        subtotal = subtotal + rate.amount
      end
      ave = subtotal/res_item.num_of_days
      res_item.ave_rate = ave
      res_item.subtotal = subtotal
      res_item.tax = subtotal * 0.1725
      res_item.total = res_item.subtotal + res_item.tax
      res_item.save!
    end
# Format confirmation email
    customer = Customer.find(session[:customer_id])
    link = modify_confirmed_reservation_url(customer.last_name, reservation.confirmation_num)
    res_info = ""
    @reservation_items.order(:rental_item_id).each do |res_item| 
      rental_type = res_item.rental_item.rental_type   
      res_info = "#{res_info}<hr>"
      res_info = "#{res_info}<p>#{rental_type.subcategory} #{rental_type.category} No. #{res_item.rental_item.name}</p>"
      
      if rental_type.category == "Cabin"       
        res_info = "#{res_info} 
                    <p>#{rental_type.num_bedrooms} #{"bedroom".pluralize(rental_type.num_bedrooms)},
                      #{rental_type.num_baths} #{"bath".pluralize(rental_type.num_baths)}<br>
                        Max Occupancy: #{rental_type.max_occupancy}</p>"
      elsif rental_type.category == "Boat"
        res_info = "#{res_info}
                    <p>Max Occupancy: #{rental_type.max_occupancy}</p>"
      elsif rental_type.category == "Boat Slip"
        res_info = "#{res_info}
          Length: #{rental_type.length}<br>
          Width: #{rental_type.width}<br>
          Height: #{rental_type.height}</p>"
      end
      res_info = "#{res_info}<b>From: </b>#{res_item.start_date.strftime('%a, %b %d, %Y')}<br>"
      if (rental_type.category == "Cabin") || (rental_type.category == "Boat Slip")
        res_info = "#{res_info}
            <b>To: </b>#{res_item.end_date.strftime('%a, %b %d, %Y')}<br>"
      else
        res_info = "#{res_info}
            <b>No. of days: </b>#{res_item.num_of_days}<br>"
      end
      res_info = "#{res_info} #{res_item.adults} #{'adult'.pluralize(res_item.adults)}, 
            #{res_item.children} #{'child'.pluralize(res_item.children)}, 
            #{res_item.pets} #{'pet'.pluralize(res_item.pets)}<br>"
      
      res_info = "#{res_info} <br>
                      <table>
                        <tr>"
      if rental_type.category == "Cabin"
          res_info = "#{res_info} <td>Ave. Nightly Rate: </td>"
      elsif rental_type.category == "Boat"
          res_info = "#{res_info} <td>Ave. Daily Rate: </td>"
      elsif rental_type.category == "Boat Slip"
          res_info = "#{res_info} <td>Ave. Monthly Rate: </td>"
      end 
      
      res_info = "#{res_info}
                          <td>$#{sprintf('%.2f', res_item.ave_rate)}</td>
                        </tr>
                        <tr>
                          <td>Subtotal:</td>
                          <td>$#{sprintf('%.2f', res_item.subtotal)}</td>
                        </tr>
                        <tr>
                          <td>Tax (17.25%)</td>
                          <td style='text-align:right'>$#{sprintf('%.2f', res_item.tax)}</td>
                        </tr>
                        <tr>
                          <td><b>Total</b></td>
                          <td><b>$#{sprintf('%.2f', res_item.total)}</b></td>
                        </tr>
                      </table>"
    end
    
    Pony.mail(
      to:       "#{customer.email}",
      subject:  "Nickajack Marina & Resorts Reservation Confirmation No. #{reservation.confirmation_num}",
      body:     "This is the body.",
      html_body: "<div style='width:500px'>
                  <h2>Nickajack Marina & Resorts</h2><br>
                    <p>
                      <b>Reservation for #{customer.first_name} #{customer.last_name} </b><br>
                      <b>Confirmation No. #{reservation.confirmation_num}</b><br>
                    </p><br>
                    <p>Dear #{customer.title} #{customer.last_name},</p>
                    <p>We are pleased to confirm your reservation with Nickajack Resorts. Below you will find details regarding your reservation. We look forward to your stay.</p>
                    <p>Nickajack Marina & Resorts</p><br>
                    <p>To modify or cancel your reservation, click <a href='#{link}'>here</a>.</p><br>
                    <p>#{res_info}</p>
                  </div>".html_safe)
    flash[:success] = "Your reservation confirmation no. is #{reservation.confirmation_num} . An email regarding your reservation has been sent."

    session[:reservation_category] = nil
    session[:reservation_subcategory] = nil
    session[:reservation_id] = nil
    session[:reservation_item_id] = nil
    session[:customer_id] = nil
    redirect_to "/" and return
  end
  
end
#====================================================================================
def modify_confirmed_reservation_get
  
  @last_name        = params[:last_name]
  @confirmation_num = params[:confirmation_num]
  render :modify_confirmed_reservation and return

end

def modify_confirmed_reservation_post
  reservation = Reservation.find_by(confirmation_num: params[:confirmation_num])
  if reservation != nil
    customer = reservation.customer
    if customer.last_name == params["last_name"]
      session[:reservation_id] = reservation.id
      session[:customer_id] = customer.id
      redirect_to "/add_reservation_item" and return
    else
      flash.now[:error] = "No reservation found. Please correct name or confirmation number and try again."
      render :modify_confirmed_reservation and return
    end  
  else
      flash.now[:error] = "No reservation found. Please correct name or confirmation number and try again."
      render :modify_confirmed_reservation and return
  end
end
#====================================================================================

def contact
end

# SUBROUTINES =======================================================================

def find_customer
  if session[:customer_id] != nil 
    @customer = Customer.find(session[:customer_id])
  elsif session[:logged_in_user_id] != nil
    user = User.find(session[:logged_in_user_id])
    @customer = Customer.find_by(email: user.email)
    session[:customer_id] = @customer.id
    if @customer == nil
      @customer = Customer.new
    end
  elsif @email != nil
    @customer = Customer.find_by(email: @email)
    if @customer == nil
      @customer = Customer.new
    end
  else
    @customer = Customer.new
  end
end


def assign_rates
# This subroutine is called from your_reservation & accepts a reservation_item
# Retrieves a rental_type (to access rates)
# Destroys previously assigned (created) rates that belong to the reservation_item
# Assigns a rate breakdown by date
# Creates a ReservationItemRate instance for each date

  rental_type = @reservation_item.rental_item.rental_type

  rates = @reservation_item.rates

  if rates != []
    rates.clear
  end

  (@reservation_item.start_date...@reservation_item.end_date).each do |date|
      if (date.strftime("%u").to_i == 5) || (date.strftime("%u").to_i == 6) 
        item_rate = rental_type.weekday_rate
      else
        item_rate = rental_type.weekend_rate
      end
      rate = Rate.new
      rate.reservation_item_id = @reservation_item.id
      rate.date    = date
      rate.amount  = item_rate
      rate.save!
  end
end

def change_reservation_item
# This subroutine is called from the "add reservation item", "guest details" 
#     and "review" pages after user requests a change to existing res item.
# It accepts @res_item_id, 
# It then redirects to the "/your reservation" page

    reservation_item = ReservationItem.find(@res_item_id)
    reservation_item.status = "available"
    reservation_item.save!
    session[:reservation_category] = reservation_item.rental_item.rental_type.category
    session[:reservation_subcategory] = reservation_item.rental_item.rental_type.subcategory
    session[:reservation_item_id] = @res_item_id
    redirect_to "/your_reservation" and return
end

def cancel_reservation_item
# This subroutine is called from the "add reservation item", "guest details" and "review" pages.
# It accepts @res_item_id and destroys the record after user requests a cancellation.
# If the reservation item has siblings, it redirects to the "add reservation item" page
# Otherwise, it also destroys the parent reservation and redirects to the home page

    res_item = ReservationItem.find(@res_item_id)
    rates = res_item.rates
    if rates.count > 0
      rates.each do |rate|
        rate.destroy!
      end
    end
    res_item.destroy!
    @reservation_items = Reservation.find(session[:reservation_id]).reservation_items
    if @reservation_items.count > 0
      session[:reservation_item_id] = nil
      flash[:info] = "Reservation item cancelled"
      redirect_to "/add_reservation_item" and return
    else 
      Reservation.find(session[:reservation_id]).destroy!
      session[:reservation_category] = nil
      session[:reservation_subcategory] = nil
      session[:reservation_id] = nil
      session[:reservation_item_id] = nil
      flash[:info] = "Your reservation has been cancelled."
      redirect_to "/" and return
    end

end

end # class MainController
