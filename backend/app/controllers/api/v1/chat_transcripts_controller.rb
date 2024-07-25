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
                
                if chat_transcript
                    render json: ChatTranscriptSerializer.new(chat_transcript).serialized_json
                else
                    render json: { error: 'ChatTranscript not found' }, status: :not_found
                end
            end

            def create
                chat_transcript = ChatTranscript.new(chat_transcript_params)
              
                if chat_transcript.save
                  render json: ChatTranscriptSerializer.new(chat_transcript).serialized_json
                else
                  Rails.logger.debug "ChatTranscript not saved: #{chat_transcript.errors.full_messages}"
                  render json: {error: chat_transcript.errors.full_messages}, status: 422
                end
              end

              def update
                chat_transcript = ChatTranscript.find_by(id: params[:id])
              
                if chat_transcript.update(chat_transcript_params)
                  render json: ChatTranscriptSerializer.new(chat_transcript).serialized_json
                else
                  render json: { error: chat_transcript.errors.full_messages }, status: :unprocessable_entity
                end
              end

              def destroy
                chat_transcript = ChatTranscript.find_by(id: params[:id])
                
                if chat_transcript.nil?
                  render json: { error: 'ChatTranscript not found' }, status: :not_found
                elsif chat_transcript.destroy
                  head :no_content
                else
                  render json: { error: chat_transcript.errors.full_messages }, status: :unprocessable_entity
                end
              end

            private

            def chat_transcript_params
                params.require(:chat_transcript).permit(:messagingUser, :message, :case_id)
            end
        end
    end
end
