require 'rails_helper'

RSpec.describe Api::V1::HumanAuditedScoresController, type: :controller do
  let!(:role) { Role.create!(name: 'Test Role') }
  let!(:employee) { Employee.create!(name: 'Test Employee', role: role, id: '5') }
  let!(:user) { User.create!(username: 'myo@gmail.com', password: '012345', employee_id: employee.id) }
  let!(:case_record) { Case.create!(messagingSection: 'Test Message Section', employee: employee) }
  let!(:ai_audited_score) { AiAuditedScore.create!(aiScore1: 'Satisfy', aiScore2: 'Unsatisfy', aiScore3: 'Satisfy', aiScore4: 'Satisfy', aiScore5: 'Unsatisfy', aiScore6: 'Satisfy', aiScore7: 'Unsatisfy', aiScore8: 'Satisfy', aiScore9: 'Satisfy', aiFeedback: 'Feedback text', totalScore: 85, isMadeCorrection: true, case: case_record) }
  let!(:human_audited_score) { HumanAuditedScore.create!(
    huScore1: 'Satisfy',
    huScore2: 'Unsatisfy',
    huScore3: 'Satisfy',
    huScore4: 'Satisfy',
    huScore5: 'Unsatisfy',
    huScore6: 'Satisfy',
    huScore7: 'Unsatisfy',
    huScore8: 'Satisfy',
    huScore9: 'Satisfy',
    huFeedback: 'Feedback text',
    huTotalScore: 85,
    user_id: user.id,
    ai_audited_score_id: ai_audited_score.id
  )}

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
      json_response = JSON.parse(response.body)
      expect(json_response['data'].size).to eq(1)
    end

    it "returns all human_audited_scores" do
      get :index
      json_response = JSON.parse(response.body)
      scores = json_response['data'].map { |score_data| score_data['attributes'] }
      expect(scores.map { |score| score['huTotalScore'] }).to contain_exactly(85)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: human_audited_score.id }
      expect(response).to be_successful
    end

    it "returns the correct human_audited_score" do
      get :show, params: { id: human_audited_score.id }
      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['huTotalScore']).to eq(85)
    end

    it "returns not found for a non-existent human_audited_score" do
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
          human_audited_score: {
            huScore1: 'Satisfy',
            huScore2: 'Satisfy',
            huScore3: 'Satisfy',
            huScore4: 'Satisfy',
            huScore5: 'Satisfy',
            huScore6: 'Satisfy',
            huScore7: 'Satisfy',
            huScore8: 'Satisfy',
            huScore9: 'Satisfy',
            huFeedback: 'New feedback',
            huTotalScore: 90,
            user_id: user.id,
            ai_audited_score_id: ai_audited_score.id
          }
        }
      end

      it 'creates a new HumanAuditedScore' do
        expect {
          post :create, params: valid_attributes
        }.to change(HumanAuditedScore, :count).by(1)
      end

      it 'renders a JSON response with the new human_audited_score' do
        post :create, params: valid_attributes
        expect(response).to be_successful
        json_response = JSON.parse(response.body)
        expect(json_response['data']['attributes']['huTotalScore']).to eq(90)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          human_audited_score: {
            huScore1: nil,
            huScore2: nil,
            huScore3: nil,
            huScore4: nil,
            huScore5: nil,
            huScore6: nil,
            huScore7: nil,
            huScore8: nil,
            huScore9: nil,
            huFeedback: nil,
            huTotalScore: nil,
            user_id: nil,
            ai_audited_score_id: nil
          }
        }
      end

      it 'does not create a new HumanAuditedScore' do
        expect {
          post :create, params: invalid_attributes
        }.to change(HumanAuditedScore, :count).by(0)
      end

      it 'renders a JSON response with errors for the new human_audited_score' do
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
          human_audited_score: {
            huScore1: 'Unsatisfy',
            huScore2: 'Unsatisfy',
            huScore3: 'Unsatisfy',
            huScore4: 'Unsatisfy',
            huScore5: 'Unsatisfy',
            huScore6: 'Unsatisfy',
            huScore7: 'Unsatisfy',
            huScore8: 'Unsatisfy',
            huScore9: 'Unsatisfy',
            huFeedback: 'Updated feedback',
            huTotalScore: 75,
            user_id: user.id,
            ai_audited_score_id: ai_audited_score.id
          }
        }
      end

      it 'updates the requested human_audited_score' do
        put :update, params: { id: human_audited_score.id, human_audited_score: valid_attributes[:human_audited_score] }
        human_audited_score.reload
        expect(human_audited_score.huTotalScore).to eq(75)
      end

      it 'renders a JSON response with the updated human_audited_score' do
        put :update, params: { id: human_audited_score.id, human_audited_score: valid_attributes[:human_audited_score] }
        expect(response).to be_successful
        json_response = JSON.parse(response.body)
        expect(json_response['data']['attributes']['huTotalScore']).to eq(75)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          human_audited_score: {
            huScore1: nil,
            huScore2: nil,
            huScore3: nil,
            huScore4: nil,
            huScore5: nil,
            huScore6: nil,
            huScore7: nil,
            huScore8: nil,
            huScore9: nil,
            huFeedback: nil,
            huTotalScore: nil,
            user_id: nil,
            ai_audited_score_id: nil
          }
        }
      end

      it 'renders a JSON response with errors' do
        put :update, params: { id: human_audited_score.id, human_audited_score: invalid_attributes[:human_audited_score] }
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to be_present
      end
    end

    context 'when the human_audited_score does not exist' do
      it 'returns not found' do
        put :update, params: { id: 9999, human_audited_score: { huScore1: 'Satisfy' } }
        expect(response).to have_http_status(:not_found)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Score not found')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:human_audited_score_to_delete) { HumanAuditedScore.create!(
      huScore1: 'Satisfy',
      huScore2: 'Unsatisfy',
      huScore3: 'Satisfy',
      huScore4: 'Satisfy',
      huScore5: 'Unsatisfy',
      huScore6: 'Satisfy',
      huScore7: 'Unsatisfy',
      huScore8: 'Satisfy',
      huScore9: 'Satisfy',
      huFeedback: 'Feedback text',
      huTotalScore: 85,
      user_id: user.id,
      ai_audited_score_id: ai_audited_score.id
    )}

    it 'destroys the requested human_audited_score' do
      expect {
        delete :destroy, params: { id: human_audited_score_to_delete.id }
      }.to change(HumanAuditedScore, :count).by(-1)
    end

    it 'renders a no content response' do
      delete :destroy, params: { id: human_audited_score_to_delete.id }
      expect(response).to have_http_status(:no_content)
    end

    it 'returns not found for a non-existent human_audited_score' do
      delete :destroy, params: { id: 9999 }
      expect(response).to have_http_status(:not_found)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('Score not found')
    end
  end
end
