module Api
    module V1
        class UnauditedCasesController < ApplicationController
            protect_from_forgery with: :null_session
            def index
                cases = Case.find_by(status: 0)
                
                render json: CaseSerializer.new(cases, options).serialized_json
                
            end

            private

            def options
                @options ||= { include: %i[chat_transcript] }
              end
        

            def case_params
                params.require(:case).permit(:messagingSection, :phoneNumber, :topic, :status, :employee_id)
            end
        end
    end
end
