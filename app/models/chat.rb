class Chat < ApplicationRecord
    self.table_name = 'chat_transcripts'  # Specify the actual table name in your database
    belongs_to :attachment, polymorphic: true
    # Your validations, associations, and other model logic here
  end