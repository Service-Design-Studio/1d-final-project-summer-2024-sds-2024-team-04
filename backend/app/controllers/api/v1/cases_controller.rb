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
                
                if cases 
                    render json: CaseSerializer.new(cases).serialized_json
                else
                    render json: { error: 'Case not found' }, status: :not_found
                end
            end

            def create
                cases = Case.new(case_params)

                if cases.save
                    render json: CaseSerializer.new(cases).serialized_json
                else
                    render json: {error: cases.errors.full_messages}, status: 422
                end
            end

            def update
                cases = Case.find_by(id: params[:id])
              
                if cases.nil?
                  render json: { error: 'Case not found' }, status: :not_found
                elsif cases.update(case_params)
                  render json: CaseSerializer.new(cases).serialized_json
                else
                  render json: { error: cases.errors.full_messages }, status: :unprocessable_entity
                end
              end
              
              

              def destroy
                case_record = Case.find_by(id: params[:id])
                
                if case_record.nil?
                  render json: { error: 'Case not found' }, status: :not_found
                elsif case_record.destroy
                  head :no_content
                else
                  render json: { error: 'Failed to destroy the case' }, status: :unprocessable_entity
                end
              end
              

            private

            def case_params
                params.require(:case).permit(:messagingSection, :phoneNumber, :topic, :status, :employee_id)
            end
        end
    end
end
