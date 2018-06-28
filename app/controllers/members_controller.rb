class MembersController < ApplicationController
  def create
    puts "Xxxxxxxxxxxxxxxxx"
    Member.create(user_id: current_user.id, group_id: params[:id])
    puts "Xxxxxxxxxxxxxxxxx"
    return redirect_to :back
  end

  def leave
    @group = Member.find(params[:id])
    if params[:like] == "Unlike" 
      @group.users.delete(current_user)

    else params[:like] == "Like"
      @group.users << current_user
    end
    redirect_to :back
  end
end
