class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    def index 
        instructors = Instructor.all 
        render json: instructors, status: :ok 
    end 
    def create 
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :ok 
    end
    def destroy 
        instructor = find_instructor
        if instructor 
            instructor.destroy 
            head :no_content 
        else
            render_not_found_response 
        end
    end
    def update 
        instructor = find_instructor
        if instructor 
            instructor.update(instructor_params)
            render json: instructor, include: :instructor, status: :accepted 
        else
            render_not_found_response 
        end
    end
    



    private
    def find_instructor
        Instructor.find_by(id: params[:id])
    end
    def instructor_params 
        params.permit(:name)
    end 
    def render_not_found_response 
        render json: {error: "Instructor not found."}, status: :not_found 
    end
end
