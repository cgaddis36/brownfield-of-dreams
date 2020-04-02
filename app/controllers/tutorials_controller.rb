# frozen_string_literal: true

class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end

  def index
    @tutorials = if current_user
                   Tutorial.all
                 else
                   classroom
                 end
  end

  private

  def classroom
    Tutorial.where('classroom = false')
  end
end
