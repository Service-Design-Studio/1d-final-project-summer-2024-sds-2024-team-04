require 'rails_helper'

RSpec.describe Api::V1::CasesController, type: :controller do
  let!(:role) { Role.create!(name: 'Test Role') }
  let!(:employee) { Employee.create!(name: 'Test Employee', email: 'test@example.com', contact_no: '1234567890', role: role) }
  let!(:case_record) { Case.create!(messagingSection: 'Test Message Section', phoneNumber: '1234567890', topic: 'Test Topic', status: 'Open', employee: employee) }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
      json_response = JSON.parse(response.body)
      expect(json_response['data'].size).to eq(1)
    end

    it "returns all cases" do
      get :index
      json_response = JSON.parse(response.body)
      messaging_sections = json_response['data'].map { |case_data| case_data['attributes']['messagingSection'] }
      expect(messaging_sections).to contain_exactly('Test Message Section')
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: case_record.id }
      expect(response).to be_successful
    end

    it "returns the correct case" do
      get :show, params: { id: case_record.id }
      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['messagingSection']).to eq('Test Message Section')
    end

    it "returns not found for a non-existent case" do
      get :show, params: { id: 9999 }
      expect(response).to have_http_status(:not_found)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('Case not found')
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) do
        {
          case: {
            messagingSection: 'New Message Section',
            phoneNumber: '0987654321',
            topic: 'New Topic',
            status: 'Closed',
            employee_id: employee.id
          }
        }
      end

      it 'creates a new Case' do
        expect {
          post :create, params: valid_attributes
        }.to change(Case, :count).by(1)
      end

      it 'renders a JSON response with the new case' do
        post :create, params: valid_attributes
        expect(response).to be_successful
        json_response = JSON.parse(response.body)
        expect(json_response['data']['attributes']['messagingSection']).to eq('New Message Section')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          case: {
            messagingSection: nil,
            phoneNumber: nil,
            topic: nil,
            status: nil,
            employee_id: nil
          }
        }
      end

      it 'does not create a new Case' do
        expect {
          post :create, params: invalid_attributes
        }.to change(Case, :count).by(0)
      end

      it 'renders a JSON response with errors for the new case' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to be_present
      end
    end
  end

  describe 'PUT #update' do
  let(:valid_attributes) do
    {
      case: {
        messagingSection: 'Updated Message Section',
        phoneNumber: '1234567890',
        topic: 'Updated Topic',
        status: 'Closed',
        employee_id: employee.id
      }
    }
  end

  context 'with valid parameters' do
    it 'updates the requested case' do
      put :update, params: { id: case_record.id, case: valid_attributes[:case] }
      case_record.reload
      expect(case_record.messagingSection).to eq('Updated Message Section')
      expect(response).to be_successful
    end

    it 'renders a JSON response with the updated case' do
      put :update, params: { id: case_record.id, case: valid_attributes[:case] }
      expect(response).to be_successful
      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['messagingSection']).to eq('Updated Message Section')
    end
  end

  context 'with invalid parameters' do
    let(:invalid_attributes) do
      {
        case: {
            messagingSection: nil,
            phoneNumber: nil,
            topic: nil,
            status: nil,
            employee_id: nil
        }
      }
    end

    it 'renders a JSON response with errors' do
      put :update, params: { id: case_record.id, case: invalid_attributes[:case] }
      expect(response).to have_http_status(:unprocessable_entity)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to be_present
    end
  end

  context 'when the case does not exist' do
    it 'returns a not found error' do
      put :update, params: { id: 9999, case: valid_attributes[:case] }
      expect(response).to have_http_status(:not_found)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('Case not found')
    end
  end
end

  describe 'DELETE #destroy' do
  context 'when the case exists' do
    let!(:case_to_delete) { Case.create!(messagingSection: 'Delete This Message', phoneNumber: '9876543210', topic: 'Delete Topic', status: 'Pending', employee: employee) }

    it 'destroys the requested case' do
      expect {
        delete :destroy, params: { id: case_to_delete.id }
      }.to change(Case, :count).by(-1)
    end

    it 'renders a no content response' do
      delete :destroy, params: { id: case_to_delete.id }
      expect(response).to have_http_status(:no_content)
    end
  end

  context 'when the case does not exist' do
    it 'returns an error if the case does not exist' do
      delete :destroy, params: { id: 9999 }
      expect(response).to have_http_status(:not_found)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('Case not found')
    end
  end

  context 'when the case cannot be destroyed' do
    let!(:case_to_delete) { Case.create!(messagingSection: 'Cannot Delete Message', phoneNumber: '5555555555', topic: 'Cannot Delete Topic', status: 'Pending', employee: employee) }

    before do
      allow_any_instance_of(Case).to receive(:destroy).and_return(false)
    end

    it 'returns an error if the case cannot be destroyed' do
      delete :destroy, params: { id: case_to_delete.id }
      #puts response.body  # Print response body for debugging
      expect(response).to have_http_status(:unprocessable_entity)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to be_present
    end
  end
end

end
