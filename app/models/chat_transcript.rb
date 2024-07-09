# app/models/chat_transcript.rb
require 'csv'

class ChatTranscript < ApplicationRecord
  def self.import_csv(file)
    CSV.foreach(file.path, headers: true) do |row|
      ChatTranscript.create!({
        messaging_session_id: row['Messaging Session Id'],
        case_id: row['Case Id'],
        assigned_queue_name: row['Assigned Queue Name'],
        assigned_officer: row['Assigned Officer'],
        messaging_user: row['Messaging User'],
        mop_phone_number: row['MOP Phone Number'],
        message: row['Message'],
        short_url: row['Short URL'],
        attachment: row['Attachment'],
        time: DateTime.parse(row['Time']) # Parsing the time to datetime format
      })
    end
  rescue StandardError => e
    puts "Error importing CSV: #{e.message}"
  end
end