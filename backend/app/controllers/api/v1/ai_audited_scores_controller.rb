module Api
    module V1
        class AiAuditedScoresController < ApplicationController
            # Skip CSRF token verification for API requests
            protect_from_forgery with: :null_session # Added to handle CSRF for API requests
            
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
<<<<<<< HEAD
                    render json: { error: ai_audited_score.errors.full_messages }, status: :unprocessable_entity
=======
                    render json: {error: ai_audited_score.errors.message}, status: 422
>>>>>>> origin/min-khant
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

<<<<<<< HEAD
                if ai_audited_score.nil?
                    render json: { error: 'Score not found' }, status: :not_found
                elsif ai_audited_score.destroy
=======
                if ai_audited_score.destroy
>>>>>>> origin/min-khant
                    head :no_content
                else
                    render json: {error: ai_audited_score.errors.message}, status: 422
                end
            end

            private

            # Edited to include :case_id in the permitted parameters
            def ai_audited_score_params
                params.require(:ai_audited_score).permit(:aiScore1, :aiScore2, :aiScore3, :aiScore4, :aiScore5, :aiScore6, :aiScore7, :aiScore8, :aiScore9, :aiFeedback, :totalScore, :isMadeCorrection, :case_id) # Added :case_id to permitted parameters
            end
        end
    end
end