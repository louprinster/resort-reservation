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

  def reservations_index
    @customers = Customer.all
    render :reservations and return
  end
  
  def reservations_index_post
  end
  
  def reservation_edit
    link = modify_confirmed_reservation_url(customer.last_name, reservation.confirmation_num)

  end
  
  def reservation_update
  end
  
  def reservation_new
  end
  
  def reservation_create
  end
  
  

end
