class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end

  def index
    if current_user
      @tutorials = Tutorial.all
    else
      @tutorials = Tutorial.all.reject{|tutorial| tutorial.classroom? }
    end
  end
end
