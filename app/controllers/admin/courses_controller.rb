class Admin::CoursesController < ApplicationController
  def index
    @courses = Course.recent.paginate page: params[:page],
      per_page: Settings.courses.per_page
  end
end
