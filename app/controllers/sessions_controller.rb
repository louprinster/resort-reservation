class SessionsController < ApplicationController
  
  layout "sessions"
  
  def login
    render :admin_login and return
  end

  def login_post
    username = params[:username]
    password = params[:password]
    admin    = Admin.where(username: username).first
    if admin == nil
      flash.now[:error] = "Unknown username"
      render :admin_login and return
    elsif admin.authenticate(password) == false
      flash.now[:error] = "Wrong password"
      render :admin_login and return
    else 
      session[:admin_id] = admin.id
#       redirect_to "/admin" and return
      redirect_to "/admin" and return
    end
  end

  def logout
    session.clear
#     redirect_to "/sessions/new" and return
    redirect_to "/admin" and return
  end


end
