# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    if current_user
      if params[:tag]
        @tutorials = Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
      else
        @tutorials = Tutorial.all.paginate(page: params[:page], per_page: 5)
      end
    else
      @tutorials = classroom
      if params[:tag]
        @tutorials = @tutorials.each { |tutorial| tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5) }
      else
        @tutorials = @tutorials.paginate(page: params[:page], per_page: 5)
      end
    end
  end

  private

  def classroom
    Tutorial.where('classroom = false')
  end
end
