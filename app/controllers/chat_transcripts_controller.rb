class ChatTranscriptsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:import]

  def import
    if request.post? && params[:file].present?
      begin
        ChatTranscript.import_csv(params[:file])
        render json: { message: 'CSV imported successfully.' }, status: :ok
      rescue StandardError => e
        render json: { error: "Error importing CSV: #{e.message}" }, status: :unprocessable_entity
      end
    else
      render json: { error: 'No file provided' }, status: :unprocessable_entity
    end
  end

  def index
    @chat_transcripts = ChatTranscript.order(created_at: :desc)
    render json: @chat_transcripts
  end
end
