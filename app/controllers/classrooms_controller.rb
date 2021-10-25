class ClassroomsController < ApplicationController
  before_action :set_school_url
  
  def index
    classrooms = Classroom.all
    @first_grade = Classroom.where(class_name: ["1-1", "1-2", "1-3", "1-4", "1-5", "1-6", "1-7", "1-8"])
    @second_grade = Classroom.where(class_name: ["2-1", "2-2", "2-3", "2-4", "2-5", "2-6", "2-7", "2-8"])
    @third_grade = Classroom.where(class_name: ["3-1", "3-2", "3-3", "3-4", "3-5", "3-6", "3-7", "3-8"])
    @fourth_grade = Classroom.where(class_name: ["4-1", "4-2", "4-3", "4-4", "4-5", "4-6", "4-7", "4-8"])
    @fifth_grade = Classroom.where(class_name: ["5-1", "5-2", "5-3", "5-4", "5-5", "5-6", "5-7", "5-8"])
    @sixth_grade = Classroom.where(class_name: ["6-1", "6-2", "6-3", "6-4", "6-5", "6-6", "6-7", "6-8"])
  end
end
