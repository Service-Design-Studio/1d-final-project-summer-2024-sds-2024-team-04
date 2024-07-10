class ChatTranscriptsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:import]

  def import
    if request.post? && params[:file].present?
      begin
        ChatTranscript.import_csv(params[:file])
        render json: { message: 'CSV file has been successfully uploaded.' }, status: :ok
      rescue StandardError => e
        render json: { error: "Error importing CSV: #{e.message}" }, status: :unprocessable_entity
      end
    end
  end

  def index
    @chat_transcripts = ChatTranscript.order(created_at: :desc)
    
  end
end
