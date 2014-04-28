class AdminController < ApplicationController
  
  layout "admin"
  
  before_action except: ["index"] do
    if session[:admin_id] != nil
      @admin = Admin.where(id: session[:admin_id]).first
    else
      flash[:error] = "You must be logged in to see that page."
#       redirect_to "/sessions/new" and return
      redirect_to "/admin/login" and return
    end
  end

  def index
    render :index and return
  end

end
