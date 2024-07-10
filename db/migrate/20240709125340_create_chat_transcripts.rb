# db/migrate/[timestamp]_create_chat_transcripts.rb
class CreateChatTranscripts < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_transcripts do |t|
      t.string :messaging_session_id
      t.string :case_id
      t.string :assigned_queue_name
      t.string :assigned_officer
      t.string :messaging_user
      t.string :mop_phone_number
      t.text :message
      t.string :short_url
      t.string :attachment # Assuming attachment is a file path or URL
      t.datetime :time
      t.timestamps
    end
  end
end
