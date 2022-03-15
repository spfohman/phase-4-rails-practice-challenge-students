class StudentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    def index 
        students = Student.all 
        render json: students, include: :instructor, status: :ok 
    end 
    def create 
        student = Student.create!(student_params)
        render json: student, include: :instructor, status: :ok 
    end
    def destroy 
        student = find_student
        if student 
            student.destroy 
            head :no_content 
        else
            render_not_found_response 
        end
    end
    def update 
        student = find_student
        if student 
            student.update(student_params)
            render json: student, include: :instructor, status: :accepted 
        else
            render_not_found_response 
        end
    end
    



    private
    def find_student
        Student.find_by(id: params[:id])
    end
    def student_params 
        params.permit(:name, :major, :age)
    end 
    def render_not_found_response 
        render json: {error: "Student not found."}, status: :not_found 
    end
end
