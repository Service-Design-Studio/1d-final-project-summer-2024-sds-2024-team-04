# app/controllers/chat_transcripts_controller.rb
class ChatTranscriptsController < ApplicationController
    def import
      if request.post?
        if params[:file].present?
          begin
            ChatTranscript.import_csv(params[:file])
            flash[:success] = 'CSV imported successfully.'
          rescue StandardError => e
            flash[:error] = "Error importing CSV: #{e.message}"
          end
          redirect_to chat_transcripts_path
        else
          flash[:error] = "No file selected."
          redirect_to import_chat_transcripts_path
        end
      else
        # GET request: Display the import form
        # You may want to initialize instance variables here if needed
      end
    end
  

    def index
        @chat_transcripts = ChatTranscript.all      
    end
end