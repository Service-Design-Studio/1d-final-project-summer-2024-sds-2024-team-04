class HumanAuditedScore < ApplicationRecord
  belongs_to :user
  belongs_to :ai_audited_score
  
end
