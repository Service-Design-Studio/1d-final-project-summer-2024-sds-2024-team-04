class AiAuditedScoreSerializer
  include FastJsonapi::ObjectSerializer
  attributes :aiScore1, :aiScore2, :aiScore3, :aiScore4, :aiScore5, :aiScore6, :aiScore7, :aiScore8, :aiScore9, :aiFeedback, :totalScore, :isMadeCorrection, :case_id, :created_at

  has_many :human_audited_score
end
