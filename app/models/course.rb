class Course < ActiveRecord::Base
  has_many :user_courses, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
  has_many :users, through: :user_courses
  has_many :subjects, through: :course_subjects
  scope :recent, ->{order created_at: :desc}
  
  validates :name, presence: Settings.courses.is_present,
    length: {minimum: Settings.courses.min_c, maximum: Settings.courses.max_c}

  def date_duration
    self.subjects.inject(0){|total_date, subject| total_date + subject.date_duration}
  end
end
