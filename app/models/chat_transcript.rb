# app/models/chat_transcript.rb
class ChatTranscript < ApplicationRecord
    def self.import_csv(file)
      CSV.foreach(file.path, headers: true) do |row|
        # Assuming your CSV has columns like :sender, :message, :timestamp, etc.
        ChatTranscript.create!(sender: row['sender'], message: row['message'], timestamp: row['timestamp'])
      end
    end
  end