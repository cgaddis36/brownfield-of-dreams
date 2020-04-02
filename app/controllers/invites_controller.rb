class InvitesController < ApplicationController

  def new
  end

  def create
    github_api = GithubService.new
    user = github_api.user_profile(params[:invite][:github_handle], current_user)
    if user[:email]
      InviteMailer.invite(user, current_user).deliver_now
      flash[:notice] = "Successfully sent invite!"
    else
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to dashboard_path
  end
end
