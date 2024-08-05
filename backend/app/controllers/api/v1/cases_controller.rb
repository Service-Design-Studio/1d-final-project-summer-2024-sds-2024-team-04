module Api
    module V1
        class CasesController < ApplicationController
            protect_from_forgery with: :null_session
            def index
                cases = Case.all

                render json: CaseSerializer.new(cases).serialized_json
            end

            def show
                cases = Case.find_by(id: params[:id])
                
                render json: CaseSerializer.new(cases).serialized_json
            end

            def create
                cases = Case.new(case_params)

                if cases.save
                    render json: CaseSerializer.new(cases).serialized_json
                else
                    render json: {error: cases.errors.message}, status: 422
                end
            end

            def update
                cases = Case.find_by(id: params[:id])

                if cases.update(case_params)
                    render json: CaseSerializer.new(cases).serialized_json
                else
                    render json: {error: cases.errors.message}, status: 422
                end
            end

            def destroy
                cases = Case.find_by(id: params[:id])

                if cases.destroy
                    head :no_content
                else
                    render json: {error: cases.errors.message}, status: 422
                end
            end

            private

            def case_params
                params.require(:case).permit(:messagingSection, :phoneNumber, :topic, :status, :employee_id)
            end
        end
    end
end
