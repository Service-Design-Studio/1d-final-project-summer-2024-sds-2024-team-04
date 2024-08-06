module Api
    module V1
        class HumanAuditedScoresController < ApplicationController
            protect_from_forgery with: :null_session
            def index
                human_audited_scores = HumanAuditedScore.all

                render json: HumanAuditedScoreSerializer.new(human_audited_scores).serialized_json
            end

            def show
                human_audited_score = HumanAuditedScore.find_by(id: params[:id])
                
                render json: HumanAuditedScoreSerializer.new(human_audited_score).serialized_json
            end

            def create
                human_audited_score = HumanAuditedScore.new(human_audited_score_params)

                if human_audited_score.save
                    render json: HumanAuditedScoreSerializer.new(human_audited_score).serialized_json
                else
                    render json: {error: human_audited_score.errors}, status: 422
                end
            end

            def update
                human_audited_score = HumanAuditedScore.find_by(id: params[:id])

                if human_audited_score.update(human_audited_score_params)
                    render json: HumanAuditedScoreSerializer.new(human_audited_score).serialized_json
                else
                    render json: {error: human_audited_score.errors}, status: 422
                end
            end

            def destroy
                human_audited_score = HumanAuditedScore.find_by(id: params[:id])

                if human_audited_score.destroy
                    head :no_content
                else
                    render json: {error: human_audited_score.errors.message}, status: 422
                end
            end

            private

            def human_audited_score_params
                params.require(:human_audited_score).permit(:huScore1, :huScore2, :huScore3, :huScore4, :huScore5, :huScore6, :huScore7, :huScore8, :huScore9, :huFeedback, :huTotalScore, :user_id, :ai_audited_score_id)
            end
        end
    end
end
