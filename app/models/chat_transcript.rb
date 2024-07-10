# app/models/chat_transcript.rb
require 'csv'

class ChatTranscript < ApplicationRecord
  def self.import_csv(file)
    CSV.foreach(file.path, headers: true) do |row|
      # Check if required fields are blank
      if row['Time'].blank?
        raise StandardError.new("CSV contains rows with missing required fields.")
      end
      
      # Your import logic here if the row passes validation
      # Example: Create or update ChatTranscript records based on row data
      ChatTranscript.create!(
        messaging_session_id: row['Messaging Session ID'],
        case_id: row['Case ID'],
        assigned_queue_name: row['Assigned Queue Name'],
        assigned_officer: row['Assigned Officer'],
        messaging_user: row['Messaging User'],
        mop_phone_number: row['MOP Phone Number'],
        message: row['Message'],
        short_url: row['Short URL'],
        attachment: row['Attachment'],
        time: row['Time']
      )
    end
  end
end