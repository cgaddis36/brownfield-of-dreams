class FriendshipsController < ApplicationController

  def create
    user_id = params[:user_id].to_i
    friend = User.where(url: "https://github.com/#{params[:friend_name]}").first
    friendship = current_user.friendships.create!(user_id: user_id, friend_id: friend.id)

    if friendship.save
      flash[:notice] = "#{params[:friend_name]} has been added as a friend!"
    else
      flash[:error] = "Friendship not created"
    end
    redirect_to dashboard_path
  end
end
