class HumanAuditedScoreSerializer
  include FastJsonapi::ObjectSerializer
  attributes :huScore1, :huScore2, :huScore3, :huScore4, :huScore5, :huScore6, :huScore7, :huScore8, :huScore9, :huFeedback, :huTotalScore, :user_id, :ai_audited_score_id, :created_at

end
