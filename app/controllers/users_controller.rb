class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    redirect_to '/users'
  end

  def show
    @user = User.find(params[:id])
    @songs = Add.where(user_id: params[:id])
    # @song = Song.where(user_id: params[:id])
  end


  def create
    if new_user.valid?
      session[:user_id] = new_user.id
      return redirect_to '/groups'
    end
    redirect_to :back, alert: new_user.errors.full_messages
  end


  private
    helper_method def user
      @user ||= User.find_by(id: params[:id])
    end

    helper_method def new_user
      @new_user ||= User.create(user_params)
    end

    def user_params
      params.require(:user).permit(:first_name,:last_name,:email,:password)
    end

end
