class AiAuditedScore < ApplicationRecord
  belongs_to :case

  has_many :human_audited_score
  
end
