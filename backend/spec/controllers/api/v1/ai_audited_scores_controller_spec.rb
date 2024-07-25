require 'rails_helper'

RSpec.describe Api::V1::AiAuditedScoresController, type: :controller do
  let!(:role) { Role.create!(name: 'Test Role') }
  let!(:employee) { Employee.create!(name: 'Test Employee', email: 'test@example.com', contact_no: '1234567890', role: role) }
  let!(:case_record) { Case.create!(messagingSection: 'Test Message Section', employee: employee) }
  let!(:ai_audited_score) { AiAuditedScore.create!(
    aiScore1: 'Satisfy',
    aiScore2: 'Unsatisfy',
    aiScore3: 'Satisfy',
    aiScore4: 'Satisfy',
    aiScore5: 'Unsatisfy',
    aiScore6: 'Satisfy',
    aiScore7: 'Unsatisfy',
    aiScore8: 'Satisfy',
    aiScore9: 'Satisfy',
    aiFeedback: 'Feedback text',
    totalScore: 85,
    isMadeCorrection: true,
    case_id: case_record.id
  )}

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
      json_response = JSON.parse(response.body)
      expect(json_response['data'].size).to eq(1)
    end

    it "returns all ai_audited_scores" do
      get :index
      json_response = JSON.parse(response.body)
      scores = json_response['data'].map { |score_data| score_data['attributes'] }
      expect(scores.map { |score| score['totalScore'] }).to contain_exactly(85)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: ai_audited_score.id }
      expect(response).to be_successful
    end

    it "returns the correct ai_audited_score" do
      get :show, params: { id: ai_audited_score.id }
      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['totalScore']).to eq(85)
    end

    it "returns not found for a non-existent ai_audited_score" do
      get :show, params: { id: 9999 }
      expect(response).to have_http_status(:not_found)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('Score not found')
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) do
        {
          ai_audited_score: {
            aiScore1: 'Satisfy',
            aiScore2: 'Satisfy',
            aiScore3: 'Satisfy',
            aiScore4: 'Satisfy',
            aiScore5: 'Satisfy',
            aiScore6: 'Satisfy',
            aiScore7: 'Satisfy',
            aiScore8: 'Satisfy',
            aiScore9: 'Satisfy',
            aiFeedback: 'New feedback',
            totalScore: 90,
            isMadeCorrection: false,
            case_id: case_record.id
          }
        }
      end

      it 'creates a new AiAuditedScore' do
        expect {
          post :create, params: valid_attributes
        }.to change(AiAuditedScore, :count).by(1)
      end

      it 'renders a JSON response with the new ai_audited_score' do
        post :create, params: valid_attributes
        expect(response).to be_successful
        json_response = JSON.parse(response.body)
        expect(json_response['data']['attributes']['totalScore']).to eq(90)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          ai_audited_score: {
            aiScore1: nil,
            aiScore2: nil,
            aiScore3: nil,
            aiScore4: nil,
            aiScore5: nil,
            aiScore6: nil,
            aiScore7: nil,
            aiScore8: nil,
            aiScore9: nil,
            aiFeedback: nil,
            totalScore: nil,
            isMadeCorrection: nil,
            case_id: nil
          }
        }
      end

      it 'does not create a new AiAuditedScore' do
        expect {
          post :create, params: invalid_attributes
        }.to change(AiAuditedScore, :count).by(0)
      end

      it 'renders a JSON response with errors for the new ai_audited_score' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to be_present
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      let(:valid_attributes) do
        {
          ai_audited_score: {
            aiScore1: 'Unsatisfy',
            aiScore2: 'Unsatisfy',
            aiScore3: 'Unsatisfy',
            aiScore4: 'Unsatisfy',
            aiScore5: 'Unsatisfy',
            aiScore6: 'Unsatisfy',
            aiScore7: 'Unsatisfy',
            aiScore8: 'Unsatisfy',
            aiScore9: 'Unsatisfy',
            aiFeedback: 'Updated feedback',
            totalScore: 75,
            isMadeCorrection: true,
            case_id: case_record.id
          }
        }
      end

      it 'updates the requested ai_audited_score' do
        put :update, params: { id: ai_audited_score.id, ai_audited_score: valid_attributes[:ai_audited_score] }
        ai_audited_score.reload
        expect(ai_audited_score.totalScore).to eq(75)
      end

      it 'renders a JSON response with the updated ai_audited_score' do
        put :update, params: { id: ai_audited_score.id, ai_audited_score: valid_attributes[:ai_audited_score] }
        expect(response).to be_successful
        json_response = JSON.parse(response.body)
        expect(json_response['data']['attributes']['totalScore']).to eq(75)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          ai_audited_score: {
            aiScore1: nil,
            aiScore2: nil,
            aiScore3: nil,
            aiScore4: nil,
            aiScore5: nil,
            aiScore6: nil,
            aiScore7: nil,
            aiScore8: nil,
            aiScore9: nil,
            aiFeedback: nil,
            totalScore: nil,
            isMadeCorrection: nil,
            case_id: nil
          }
        }
      end

      it 'renders a JSON response with errors' do
        put :update, params: { id: ai_audited_score.id, ai_audited_score: invalid_attributes[:ai_audited_score] }
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to be_present
      end
    end

    context 'when the ai_audited_score does not exist' do
      it 'returns not found' do
        put :update, params: { id: 9999, ai_audited_score: { aiScore1: 'Satisfy' } }
        expect(response).to have_http_status(:not_found)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Score not found')
      end
    end
  end

  describe 'DELETE #destroy' do
  let!(:ai_audited_score_to_delete) { AiAuditedScore.create!(
    aiScore1: 'Satisfy',
    aiScore2: 'Unsatisfy',
    aiScore3: 'Satisfy',
    aiScore4: 'Satisfy',
    aiScore5: 'Unsatisfy',
    aiScore6: 'Satisfy',
    aiScore7: 'Unsatisfy',
    aiScore8: 'Satisfy',
    aiScore9: 'Satisfy',
    aiFeedback: 'Feedback text',
    totalScore: 85,
    isMadeCorrection: true,
    case_id: case_record.id
  )}

  it 'destroys the requested ai_audited_score' do
    expect {
      delete :destroy, params: { id: ai_audited_score_to_delete.id }
    }.to change(AiAuditedScore, :count).by(-1)
  end

  it 'renders a no content response' do
    delete :destroy, params: { id: ai_audited_score_to_delete.id }
    expect(response).to have_http_status(:no_content)
  end

  it 'returns an error if the ai_audited_score does not exist' do
    delete :destroy, params: { id: 9999 }
    expect(response).to have_http_status(:not_found)
    json_response = JSON.parse(response.body)
    expect(json_response['error']).to eq('Score not found')
  end

  it 'returns an error if the ai_audited_score cannot be destroyed' do
    allow_any_instance_of(AiAuditedScore).to receive(:destroy).and_return(false)
    delete :destroy, params: { id: ai_audited_score_to_delete.id }
    expect(response).to have_http_status(:unprocessable_entity)
    json_response = JSON.parse(response.body)
    expect(json_response['error']).to be_present
  end
end

end
