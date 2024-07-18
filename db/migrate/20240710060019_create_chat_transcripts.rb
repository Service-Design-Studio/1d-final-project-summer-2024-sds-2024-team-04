class CreateChatTranscripts < ActiveRecord::Migration[7.2]
  def change
    create_table :chat_transcripts do |t|
      t.string :messagingUser
      t.string :message
      t.string :shortURL
      t.string :attachmentURL
      t.belongs_to :case, null: false, foreign_key: true

      t.timestamps
    end
  end
end
