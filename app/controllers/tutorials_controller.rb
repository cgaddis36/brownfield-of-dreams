class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end

  def index
    if current_user
      @tutorials = Tutorial.all
    else
      @tutorials = classroom
    end
  end
  
  private
  def classroom
    Tutorial.where('classroom = false')
  end
end
