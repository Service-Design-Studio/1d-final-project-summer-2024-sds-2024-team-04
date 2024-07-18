module Api
    module V1
        class AiAuditedScoresController < ApplicationController
            protect_from_forgery with: :null_session
            def index
                ai_audited_scores = AiAuditedScore.all

                render json: AiAuditedScoreSerializer.new(ai_audited_scores).serialized_json
            end

            def show
                ai_audited_score = AiAuditedScore.find_by(id: params[:id])
                
                render json: AiAuditedScoreSerializer.new(ai_audited_score).serialized_json
            end

            def create
                ai_audited_score = AiAuditedScore.new(ai_audited_score_params)

                if ai_audited_score.save
                    render json: AiAuditedScoreSerializer.new(ai_audited_score).serialized_json
                else
                    render json: {error: ai_audited_score.errors.message}, status: 422
                end
            end

            def update
                ai_audited_score = AiAuditedScore.find_by(id: params[:id])

                if ai_audited_score.update(ai_audited_score_params)
                    render json: AiAuditedScoreSerializer.new(ai_audited_score).serialized_json
                else
                    render json: {error: ai_audited_score.errors.message}, status: 422
                end
            end

            def destroy
                ai_audited_score = AiAuditedScore.find_by(id: params[:id])

                if ai_audited_score.destroy
                    head :no_content
                else
                    render json: {error: ai_audited_score.errors.message}, status: 422
                end
            end

            private

            def ai_audited_score_params
                params.require(:ai_audited_score).permit(:name, :description)
            end
        end
    end
end
