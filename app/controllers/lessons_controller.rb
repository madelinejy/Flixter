class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson, only: [:show]

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = current_section.lessons.create(lesson_params)
    redirect_to instructor_course_path(current_section.course)
  end

  def show
  end

	# def require_authorized_for_current_section
	#     if current_section.course.user != current_user
	#       render plain: 'Unauthorized', status: :unauthorized
	#     end
 #    end
  private

  def require_authorized_for_current_lesson
    unless current_user.enrolled_in? @course
      redirect_to course_enrollments_path, alert: 'You must Enroll before viewing this page'
    end
  end

  helper_method :current_lesson

  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :subtitle, :video)
  end
end
