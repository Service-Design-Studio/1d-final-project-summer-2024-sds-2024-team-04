class Case < ApplicationRecord
  belongs_to :employee

  has_many :chat_transcript
  has_one :ai_audited_score

end
