class Admin::CoursesController < ApplicationController
  def index
    @courses = Course.recent.paginate page: params[:page],
      per_page: Settings.courses.per_page
  end

  def new
    @users = User.all
    @subjects = Subject.all
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = t "views.messages.create_successfully"
      redirect_to admin_courses_path
    else
      @users = User.all
      @subjects = Subject.all
      @course = Course.new
      render :new
    end
  end

  private
  def course_params
    params.require(:course).permit :name, :description,
      user_ids: [], subject_ids: []
  end
end
