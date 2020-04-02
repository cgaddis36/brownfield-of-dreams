# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    if current_user
      tutorials
    else
      tutorials_class
    end
  end

  private

  def tutorials_class
    @tutorials = classroom
    @tutorials = if params[:tag]
                   @tutorials.each { |tutorial| tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5) }
                 else
                   @tutorials.paginate(page: params[:page], per_page: 5)
                 end
  end

  def tutorials
    @tutorials = if params[:tag]
                   Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
                 else
                   Tutorial.all.paginate(page: params[:page], per_page: 5)
                 end
  end

  def classroom
    Tutorial.where('classroom = false')
  end
end
