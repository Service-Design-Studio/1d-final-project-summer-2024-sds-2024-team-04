class ChatTranscriptSerializer
  include FastJsonapi::ObjectSerializer
  attributes :messagingUser, :message, :shortURL, :attachmentURL, :case_id, :created_at
end
