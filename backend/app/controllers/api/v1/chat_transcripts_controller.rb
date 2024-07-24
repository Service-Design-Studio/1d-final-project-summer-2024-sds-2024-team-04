module Api
    module V1
        class ChatTranscriptsController < ApplicationController
            protect_from_forgery with: :null_session
            def index
                chat_transcripts = ChatTranscript.all

                render json: ChatTranscriptSerializer.new(chat_transcripts).serialized_json
            end

            def show
                chat_transcript = ChatTranscript.find_by(id: params[:id])
                
                render json: ChatTranscriptSerializer.new(chat_transcript).serialized_json
            end

            def create
                chat_transcript = ChatTranscript.new(chat_transcript_params)

                if chat_transcript.save
                    render json: ChatTranscriptSerializer.new(chat_transcript).serialized_json
                else
                    render json: {error: chat_transcript.errors.message}, status: 422
                end
            end

            def update
                chat_transcript = ChatTranscript.find_by(id: params[:id])

                if chat_transcript.update(chat_transcript_params)
                    render json: ChatTranscriptSerializer.new(chat_transcript).serialized_json
                else
                    render json: {error: chat_transcript.errors.message}, status: 422
                end
            end

            def destroy
                chat_transcript = ChatTranscript.find_by(id: params[:id])

                if chat_transcript.destroy
                    head :no_content
                else
                    render json: {error: chat_transcript.errors.message}, status: 422
                end
            end

            private

            def chat_transcript_params
                params.require(:chat_transcript).permit(:name, :description)
            end
        end
    end
end
