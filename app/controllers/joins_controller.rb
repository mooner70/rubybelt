class JoinsController < ApplicationController
  def create
    puts "Xxxxxxxxxxxxxxxxx"
    Member.create(user_id: current_user.id, group_id: params[:id])
    puts "Xxxxxxxxxxxxxxxxx"
    return redirect_to :back
  end
end
