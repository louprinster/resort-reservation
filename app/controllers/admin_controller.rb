class AdminController < ApplicationController
  
  layout "admin"
  
  before_action except: ["index"] do
    if session[:admin_id] != nil
      @admin = Admin.where(id: session[:admin_id]).first
    else
      flash[:error] = "You must be logged in to see that page."
      redirect_to "/sessions/login" and return
    end
  end

  def index
    render :index and return
  end


  def customers_index
    @customers = Customer.order(:last_name)
    @u_s_states  = USState.order(:name).all
    
    if @customers == nil
      flash.now[:info] = "No customers to display"
    end
    render :customers and return
  end

  def customers_index_post
    customer_id = params[:customer_id]
    if params[:commit] == "Reservations"
      redirect_to "/:customer_id/reservations" and return
    elsif params[:commit] == "Delete"
      customer = Customer.find(customer_id)
      customer.destroy!
      flash[:success] = "Customer deleted."
      redirect_to "/admin/customers" and return  
    end
  end
  
  def customer_edit
    @customer = Customer.find(params[:id])
    @u_s_states  = USState.order(:name).all
    render :edit_customer and return    
  end
  
  def customer_update
    @customer = Customer.find(params[:id])
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
      flash[:success] = "Customer updated."
      redirect_to "/admin/customers" and return
    else
      @u_s_states  = USState.order(:name).all
      render :edit_customer and return
    end
  end

  def customer_new
    @customer = Customer.new
    @u_s_states  = USState.order(:name).all
    render :new_customer and return
  end
  
  def customer_create
    @customer = Customer.new
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
      flash[:success] = "Customer created."
      redirect_to "/admin/customers" and return
    else
      @u_s_states  = USState.order(:name).all
      render :new_customer and return
    end
  end

  def customer_reservations
    @customers = Customer.where(id: params[:id])
    render :reservations and return
  end

#========================================================================

  def reservations_index
    @customers = Customer.all
    render :reservations and return
  end
  
  def reservations_index_post
    if params[:commit] == "Delete"
      reservation = Reservation.find(params[:reservation_id])
      reservation.destroy!
      flash[:success] = "Reservation deleted"
      redirect_to "/admin/reservations" and return
    end
  end
  
  def reservation_edit
    session[:reservation_id] = params[:id]
    customer = Reservation.find(params[:id]).customer
    session[:customer_id] = customer.id
    redirect_to "/add_reservation_item" and return
  end
  
#=======================================================================  
  
  def category_index
    @category = params[:category].capitalize
    render :rentaltypes and return 
  end
  
  def category_index_post
    if params[:commit] == "Delete"
      rental_type = RentalType.find(params[:rental_type_id])
      category = rental_type.category
      rental_type.destroy!
      flash[:success] = "Rental Type deleted"
      redirect_to "/admin/#{category}" and return
    end    
  end
  
  def category_edit
    @rental_type = RentalType.find(params[:id])
    @post_route  = "/#{params[:category]}/#{params[:id]}/update"
    render :rentaltype_edit_new and return
  end

  def category_update
    @rental_type = RentalType.find(params[:id])
    @rental_type.subcategory = params[:subcategory]
    @rental_type.max_occupancy = params[:max_occupancy]
    @rental_type.description   = params[:description]
    @rental_type.num_bedrooms  = params[:num_bedrooms]
    @rental_type.num_baths     = params[:num_baths]
    @rental_type.weekday_rate  = params[:weekday_rate]
    @rental_type.weekend_rate  = params[:weekend_rate]
    category = params[:category]
    if @rental_type.save
      flash[:success] = "#{category} updated/created"
      redirect_to "/admin/#{category}" and return
    else
      render :rentaltype_edit_new and return
    end
  end

  def category_new
    @rental_type = RentalType.new
    @rental_type.category = params[:category]
    @post_route  = "/#{params[:category]}/create"
    render :rentaltype_edit_new and return
  end

  def category_create
    @rental_type = RentalType.new
    @rental_type.category      = params[:category]
    @rental_type.subcategory   = params[:subcategory]
    @rental_type.max_occupancy = params[:max_occupancy]
    @rental_type.description   = params[:description]
    @rental_type.num_bedrooms  = params[:num_bedrooms]
    @rental_type.num_baths     = params[:num_baths]
    @rental_type.weekday_rate  = params[:weekday_rate]
    @rental_type.weekend_rate  = params[:weekend_rate]
    category = params[:category]
    if @rental_type.save
      flash[:success] = "#{category} updated/created"
      redirect_to "/admin/#{category}" and return
    else
      render :rentaltype_edit_new and return
    end
  end

end
