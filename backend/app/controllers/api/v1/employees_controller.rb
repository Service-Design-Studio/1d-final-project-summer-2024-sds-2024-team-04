module Api
    module V1
        class EmployeesController < ApplicationController
            protect_from_forgery with: :null_session
            def index
                employees = Employee.all

                render json: EmployeeSerializer.new(employees).serialized_json
            end

            def show
                employee = Employee.find_by(id: params[:id])
                
                render json: EmployeeSerializer.new(employee).serialized_json
            end

            def create
                employee = Employee.new(employee_params)

                if employee.save
                    render json: EmployeeSerializer.new(employee).serialized_json
                else
                    render json: {error: employee.errors.message}, status: 422
                end
            end

            def update
                employee = Employee.find_by(id: params[:id])

                if employee.update(employee_params)
                    render json: EmployeeSerializer.new(employee).serialized_json
                else
                    render json: {error: employee.errors.message}, status: 422
                end
            end

            def destroy
                employee = Employee.find_by(id: params[:id])

                if employee.destroy
                    head :no_content
                else
                    render json: {error: employee.errors.message}, status: 422
                end
            end

            private
            
            def employee_params
                params.require(:employee).permit(:name, :email, :contact_no, :role_id)
            end
        end
    end
end
