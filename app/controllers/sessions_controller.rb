class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.find_by(email: params[:email])
    errors = []
    if @user
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        return redirect_to "/groups"
      else
        errors << 'Invalid password' # errors << is the same as errors.push
      end

    else
      errors << 'No account with that email exists. Please register first.'
    end
    redirect_to :back, alert: errors
  end

  def destroy
    session.delete :user_id if session.key? 'user_id'
    redirect_to '/users'
  end

  def create
    users = User.find_by(email: params[:email])
    
    if users && users.authenticate(params[:password])
      session[:id] = users.id
      render "/users"
      else 
          flash[:alert] = users.errors.full_messages
          redirect_to "/users"          
    end
  end
end
