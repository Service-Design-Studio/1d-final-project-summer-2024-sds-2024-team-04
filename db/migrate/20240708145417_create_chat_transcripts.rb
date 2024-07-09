class CreateChatTranscripts < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_transcripts do |t|
      t.integer :chat_id
      t.integer :messaging_section_id
      t.integer :case_id
      t.integer :assigned_officer_id
      t.string :messaging_user
      t.integer :MOP_phone_number
      t.text :message
      t.string :short_url
      t.references :attachment, polymorphic: true, null: true
      t.text :topic
      t.time :datetime
      t.boolean :isAudited

      t.timestamps
    end
  end
end
