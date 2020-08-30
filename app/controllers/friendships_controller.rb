class FriendshipsController < ApplicationController

  def create
    friend = User.find(params[:friend])

    current_user.friendships.build(friend_id: friend.id)
    if current_user.save
      flash[:notice] = "You are now following #{friend.first_name}."
    else
      flash[:alert] = "Oops! Something went wrong trying to track #{friend.first_name}."
    end
    redirect_to my_friends_path
  end

  def destroy
    friend = User.find(params[:id]).full_name
    friendship = Friendship.where(user_id: current_user.id, friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "You are no longer following #{friend}."
    redirect_to my_friends_path
  end
end
