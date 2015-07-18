class CoursesController < ApplicationController
  before_action :init_course, only: :show
  before_action :member_of_course, only: :show

  def show
    authorize! :show, @course
  end

  private
  def init_course
    @course = Course.find params[:id]
  end

  def member_of_course
    unless @course.has_member? current_user
      flash[:danger] = t "views.messages.you_arenot_member"
      redirect_to root_path
    end
  end
end
