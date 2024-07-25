require 'rails_helper'

RSpec.describe Api::V1::RolesController, type: :controller do
  let!(:role) { Role.create!(name: 'Test Role', description: 'A test role') }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
      expect(JSON.parse(response.body)['data'].size).to eq(1)
    end

    it "returns all roles" do
      get :index
      json_response = JSON.parse(response.body)
      role_names = json_response['data'].map { |role| role['attributes']['name'] }
      expect(role_names).to contain_exactly('Test Role')
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: role.id }
      expect(response).to be_successful
    end

    it "returns the correct role" do
      get :show, params: { id: role.id }
      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['name']).to eq('Test Role')
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) do
        {
          role: {
            name: 'New Role',
            description: 'A new role'
          }
        }
      end

      it 'creates a new Role' do
        expect {
          post :create, params: valid_attributes
        }.to change(Role, :count).by(1)
      end

      it 'renders a JSON response with the new role' do
        post :create, params: valid_attributes
        expect(response).to be_successful
        expect(response.body).to include('New Role')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          role: {
            name: nil,
            description: 'A new role'
          }
        }
      end

      it 'does not create a new Role' do
        expect {
          post :create, params: invalid_attributes
        }.to change(Role, :count).by(0)
      end

      it 'renders a JSON response with errors for the new role' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('error')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      let(:valid_attributes) do
        {
          role: {
            name: 'Updated Role',
            description: 'An updated role'
          }
        }
      end

      it 'updates the requested role' do
        put :update, params: { id: role.id, role: valid_attributes[:role] }
        role.reload
        expect(role.name).to eq('Updated Role')
      end

      it 'renders a JSON response with the updated role' do
        put :update, params: { id: role.id, role: valid_attributes[:role] }
        expect(response).to be_successful
        expect(response.body).to include('Updated Role')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          role: {
            name: nil,
            description: 'An updated role'
          }
        }
      end

      it 'does not update the role' do
        put :update, params: { id: role.id, role: invalid_attributes[:role] }
        role.reload
        expect(role.name).to eq('Test Role')
      end

      it 'renders a JSON response with errors for the role' do
        put :update, params: { id: role.id, role: invalid_attributes[:role] }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('error')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when the role exists' do
      it 'destroys the requested role' do
        expect {
          delete :destroy, params: { id: role.id }
        }.to change(Role, :count).by(-1)
      end

      it 'returns a no content response' do
        delete :destroy, params: { id: role.id }
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the role does not exist' do
      it 'returns an unprocessable entity response with errors' do
        allow_any_instance_of(Role).to receive(:destroy).and_return(false)
        delete :destroy, params: { id: role.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('error')
      end
    end
  end
end
