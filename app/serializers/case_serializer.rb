class CaseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :messagingSection, :phoneNumber, :topic, :status, :employee_id, :created_at

  has_many :chat_transcript
  has_one :ai_audited_score
end
