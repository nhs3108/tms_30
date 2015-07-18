class Admin::SubjectsController < ApplicationController
  before_action :init_subject, only: [:edit, :update]

  def index
    @subjects = Subject.recent.paginate page: params[:page],
      per_page: Settings.subjects.per_page
  end

  def new
    @subject = Subject.new
    @task = @subject.tasks.build
  end

  def edit    
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = t "views.messages.create_successfully"
      redirect_to admin_subjects_path
    else
      @task = @subject.tasks.build
      render :new
    end
  end

  def update
    if @subject.update subject_params
      flash[:success] = t "views.messages.update_successfully"
      redirect_to admin_subjects_path
    else
      render :edit
    end
  end

  private
  def init_subject
    @subject = Subject.find params[:id]
  end

  def subject_params
    params.require(:subject).permit :name, :description, :date_duration,
      tasks_attributes: [:id, :name, :description, :_destroy]
  end
end
