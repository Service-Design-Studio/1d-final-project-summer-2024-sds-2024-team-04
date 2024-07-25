require 'rails_helper'

RSpec.describe Api::V1::ChatTranscriptsController, type: :controller do
  let!(:role) { Role.create!(name: 'Test Role') }
  let!(:employee) { Employee.create!(name: 'Test Employee', email: 'test@example.com', contact_no: '1234567890', role: role) }
  let!(:case_record) { Case.create!(messagingSection: 'Test Message Section', employee: employee) }
  let!(:chat_transcript) { ChatTranscript.create!(messagingUser: 'Test User', message: 'Test Message', case: case_record) }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
      expect(JSON.parse(response.body)['data'].size).to eq(1)
    end

    it "returns all chat transcripts" do
      get :index
      json_response = JSON.parse(response.body)
      messaging_users = json_response['data'].map { |chat_transcript| chat_transcript['attributes']['messagingUser'] }
      expect(messaging_users).to contain_exactly('Test User')
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: chat_transcript.id }
      expect(response).to be_successful
    end

    it "returns the correct chat transcript" do
      get :show, params: { id: chat_transcript.id }
      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['messagingUser']).to eq('Test User')
    end

    it "returns not found for a non-existent chat transcript" do
      get :show, params: { id: 9999 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) do
        {
          chat_transcript: {
            messagingUser: 'New User',
            message: 'New Message',
            case_id: case_record.id
          }
        }
      end

      it 'creates a new ChatTranscript' do
        expect {
          post :create, params: valid_attributes
        }.to change(ChatTranscript, :count).by(1)
      end

      it 'renders a JSON response with the new chat transcript' do
        post :create, params: valid_attributes
        #puts response.body # Add this line to print the response body
        expect(response).to be_successful
        json_response = JSON.parse(response.body)
        expect(json_response['data']['attributes']['messagingUser']).to eq('New User')
        expect(json_response['data']['attributes']['message']).to eq('New Message')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          chat_transcript: {
            messagingUser: nil,
            message: nil,
            case_id: nil
          }
        }
      end

      it 'does not create a new ChatTranscript' do
        expect {
          post :create, params: invalid_attributes
        }.to change(ChatTranscript, :count).by(0)
      end

      it 'renders a JSON response with errors for the new chat transcript' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to be_present
      end
    end

  describe 'PUT #update' do
    let(:valid_attributes) do
    {
      chat_transcript: {
            messagingUser: 'Updated User',
            message: 'Updated Message',
            case_id: case_record.id
        }
    }
    end

    let(:invalid_attributes) do
    {
        chat_transcript: {
            messagingUser: nil,
            message: nil,
            case_id: nil
        }
    }
    end

      context 'with valid parameters' do
        it 'updates the requested chat transcript' do
        put :update, params: { id: chat_transcript.id }.merge(valid_attributes)
        chat_transcript.reload
        expect(chat_transcript.messagingUser).to eq('Updated User')
        expect(chat_transcript.message).to eq('Updated Message')
        end

        it 'renders a JSON response with the updated chat transcript' do
        put :update, params: { id: chat_transcript.id }.merge(valid_attributes)
        expect(response).to be_successful
        json_response = JSON.parse(response.body)
        expect(json_response['data']['attributes']['messagingUser']).to eq('Updated User')
        expect(json_response['data']['attributes']['message']).to eq('Updated Message')
        end
    end

    context 'with invalid parameters' do
        it 'does not update the chat transcript' do
        put :update, params: { id: chat_transcript.id }.merge(invalid_attributes)
        chat_transcript.reload
        expect(chat_transcript.messagingUser).to eq('Test User')
        expect(chat_transcript.message).to eq('Test Message')
        end

        it 'renders a JSON response with errors for the chat transcript' do
        put :update, params: { id: chat_transcript.id }.merge(invalid_attributes)
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to be_present
        end
      end
    end

    describe 'DELETE #destroy' do
    let!(:chat_transcript_to_delete) { ChatTranscript.create!(messagingUser: 'User to delete', message: 'Message to delete', case: case_record) }
  
    it 'destroys the requested chat transcript' do
      expect {
        delete :destroy, params: { id: chat_transcript_to_delete.id }
      }.to change(ChatTranscript, :count).by(-1)
    end
  
    it 'renders a no content response' do
      delete :destroy, params: { id: chat_transcript_to_delete.id }
      expect(response).to have_http_status(:no_content)
    end
  
    it 'returns an error if the chat transcript does not exist' do
      delete :destroy, params: { id: 9999 }
      expect(response).to have_http_status(:not_found)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('ChatTranscript not found')
    end
  
    it 'returns an error if the chat transcript cannot be destroyed' do
      chat_transcript_to_delete # Create the chat transcript for the test
      allow_any_instance_of(ChatTranscript).to receive(:destroy).and_return(false)
      allow_any_instance_of(ChatTranscript).to receive_message_chain(:errors, :full_messages).and_return(['Some error message'])
      
      delete :destroy, params: { id: chat_transcript_to_delete.id }
      expect(response).to have_http_status(:unprocessable_entity)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to include('Some error message')
    end
  end
  end
end
