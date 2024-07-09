class ChatTranscriptsController < ApplicationController
    def import
      if request.post? && params[:file].present?
        begin
          ChatTranscript.import_csv(params[:file])
          flash[:success] = 'CSV imported successfully.'
        rescue StandardError => e
          flash[:error] = "Error importing CSV: #{e.message}"
        end
        redirect_to chat_transcripts_path
      end
    end
  
    def index
        @chat_transcripts = ChatTranscript.order(created_at: :desc)
        render json: @chat_transcripts
    end
  end
  