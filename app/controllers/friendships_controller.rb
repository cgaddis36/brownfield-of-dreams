# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    user_id = params[:user_id].to_i
    friend = User.where(url: "https://github.com/#{params[:friend_name]}").first
    current_user.friendships.create!(user_id: user_id, friend_id: friend.id)
    flash[:notice] = "#{params[:friend_name]} has been added as a friend!"
    redirect_to dashboard_path
  end
end
