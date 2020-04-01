# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @bookmarks = current_user.bookmark_finder
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      email_activation(user)
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def email_activation(user)
    flash[:notice] = "Logged in as #{user.first_name} #{user.last_name}"
    flash[:error] = 'This account has not yet been activated. Please check your email.'

    AccountActivationMailer.inform(user).deliver_now
  end
end
