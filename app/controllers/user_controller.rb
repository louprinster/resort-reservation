class UserController < ApplicationController
  layout "user"
  before_filter do
    @logged_in_user = User.where(id: session[:logged_in_user_id]).first
    if @logged_in_user != nil && @logged_in_user.was_email_verified != true
      flash.now[:remind_to_verify_email] = true
    end
  end
  
#   before_filter except: ["index", "login", "logout"] do
#     if @author == nil
#       flash[:error]            = "You must be logged in to view that page"
#       redirect_to "/login" and return
#     end
#   end

  def index
    @users = User.order("id")
    render :index and return
  end

  def new
    @user = User.new
    render :new and return
  end

  def create
    @user                          = User.new
    @user.email                    = params[:email]
    @user.password                 = params[:password]
    @user.password_confirmation    = params[:password_confirmation]
    @user.email_verification_token = rand(10 ** 8)
    if @user.save == true
      session[:logged_in_user_id] = @user.id
      flash[:success] = "Your account has been created"

      link = verify_email_url(@user.id, @user.email_verification_token)
      
      Pony.mail(
        to:        @user.email,
        subject:   "Thanks for registering",
        body:      "Please click the following link to verify your email address: #{link}",
        html_body: "Please click <a href='#{link}'>here</a> to verify your email address."
      )

      session[:logged_in_user_id] = @user.id

      determine_route
#       redirect_to user_index_path and return
    else
      render :new and return
    end

  end

  def login
    named_user = User.where(email: params[:email]).first
    if named_user && named_user.authenticate(params[:password])
      session[:logged_in_user_id] = named_user.id
    else
      flash[:error] = "Wrong email or password"
    end
      determine_route
#       redirect_to user_index_path and return
  end

  def logout
    original_route = session[:original_route]
    session[:logged_in_user_id] = nil
    if original_route != nil
      session[:original_route] = nil
      redirect_to original_route and return
    else
      redirect_to "/" and return
    end 
 
  end

  def verify_email
    user = User.where(id: params[:user_id]).first
    if user != nil
      if user.email_verification_token == params[:token]
        user.was_email_verified = true
        user.save!
        flash[:success] = "Email has been verified."
        session[:logged_in_user_id] = user.id
      else
        flash[:error] = "Wrong email verification token"
      end
      determine_route
    else
      flash[:error] = "Couldn't find user with that ID"
    end
  end

  def resend_verification_email
    Pony.mail(
      to:      @logged_in_user.email,
      subject: "Thanks for registering",
      body:    "Please click the following link to verify your email address:
#{verify_email_url(@logged_in_user.id, @logged_in_user.email_verification_token)}"
    )
    flash[:success] = "Verification email sent."
      redirect_to user_index_path and return
  end

  def forgot_password
    render :forgot_password and return
  end

  def forgot_password_post
    user = User.find_by(email: params["email"])
    if user != nil
      Pony.mail(
        to:      user.email,
        subject: "Password reset request",
        body:    "Please click the following link to reset your password:
#{reset_password_url(user.id, user.email_verification_token)}"
      )
      flash[:success] = "Password reset email sent."
#       determine_route
      redirect_to user_index_path and return
    else
      flash[:error] = "Couldn't find user record for that email."
#       determine_route
      redirect_to user_index_path and return

    end
  end

  def reset_password
    @user = User.where(id: params[:user_id]).first
    if @user != nil
      if @user.email_verification_token == params[:token]
        @user.was_email_verified = true
        @user.save!
        session[:logged_in_user_id] = @user.id
      else
        flash[:error] = "Wrong email verification token"
      end
      render :reset_password and return
    else
      flash[:error] = "Couldn't find user with that ID"
    end
  end

  def reset_password_post
    @user = @logged_in_user
    if params[:password] == ""
      flash.now[:error] = "Password cannot be blank."
      render :reset_password and return
    else
      @user.password                 = params[:password]
      @user.password_confirmation    = params[:password_confirmation]
      if @user.save == true
        flash[:success] = "Password has been set."
#         redirect_to params[:afterwards_go_to]
      determine_route
#       redirect_to user_index_path and return

      else
        render :reset_password and return
      end
    end
  end
  
  def determine_route
      original_route = session[:original_route]
      if original_route != nil
        session[:original_route] = nil
        redirect_to original_route and return
      else
        redirect_to "/" and return
      end 
   end    

  
  
  
end
