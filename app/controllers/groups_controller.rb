class GroupsController < ApplicationController

  def index
    @groups = Group.all
  end
  
  def show
    @groups = Group.find(params[:id])
    @members = Member.where(group_id: params[:id])
    
  end
  
  def create
    group = Group.create(name: params[:name], description: params[:description], user_id: current_user.id)
    if group.valid?
      Member.create(user_id: current_user.id, group_id: group.id)
      return redirect_to "/groups"
    end
    redirect_to :back, alert: group.errors.full_messages
  end
  
  def join
    puts "Xxxxxxxxxxxxxxxxx"
    Member.create(user_id: current_user.id, group_id: params[:id])
    puts "Xxxxxxxxxxxxxxxxx"
    return redirect_to :back
  end

  def leave
    @group = Member.find(params[:id])
    if params[:leave] == "leave" 
      @group.user.delete(current_user)

    else params[:leave] == "join"
      @group.user << current_user
    end
    redirect_to :back
  end
  
end
