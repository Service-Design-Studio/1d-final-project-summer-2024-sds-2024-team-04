require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let!(:role) { Role.create!(name: 'Test Role') }
  let!(:employee) { Employee.create!(name: 'Test Employee', role: role, id: '5') }
  let!(:user) { User.create!(username: 'myo@gmail.com', password: '012345', employee_id: employee.id) }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
      expect(JSON.parse(response.body)['data'].size).to eq(1)
    end

    it "returns all users" do
      get :index
      json_response = JSON.parse(response.body)
      usernames = json_response['data'].map { |user| user['attributes']['username'] }
      expect(usernames).to contain_exactly('myo@gmail.com')
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: user.id }
      expect(response).to be_successful
    end

    it "returns the correct user" do
      get :show, params: { id: user.id }
      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['username']).to eq('myo@gmail.com')
    end

    it "returns not found for a non-existent user" do
      get :show, params: { id: 9999 }
      expect(response).to have_http_status(:not_found)
      expect(response.body).to include('User not found')
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) do
        {
          user: {
            username: 'newuser@gmail.com',
            password: 'newpassword',
            employee_id: employee.id
          }
        }
      end

      it 'creates a new User' do
        expect {
          post :create, params: valid_attributes
        }.to change(User, :count).by(1)
      end

      it 'renders a JSON response with the new user' do
        post :create, params: valid_attributes
        expect(response).to be_successful
        expect(response.body).to include('newuser@gmail.com')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          user: {
            username: nil,
            password: 'newpassword',
            employee_id: nil
          }
        }
      end

      it 'does not create a new User' do
        expect {
          post :create, params: invalid_attributes
        }.to change(User, :count).by(0)
      end

      it 'renders a JSON response with errors for the new user' do
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
          user: {
            username: 'updateduser@gmail.com',
            password: 'newpassword',
            employee_id: employee.id
          }
        }
      end

      it 'updates the requested user' do
        put :update, params: { id: user.id, user: valid_attributes[:user] }
        user.reload
        expect(user.username).to eq('updateduser@gmail.com')
      end

      it 'renders a JSON response with the updated user' do
        put :update, params: { id: user.id, user: valid_attributes[:user] }
        expect(response).to be_successful
        expect(response.body).to include('updateduser@gmail.com')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          user: {
            username: nil,
            password: 'newpassword',
            employee_id: nil
          }
        }
      end

      it 'does not update the user' do
        put :update, params: { id: user.id, user: invalid_attributes[:user] }
        user.reload
        expect(user.username).to eq('myo@gmail.com')
      end

      it 'renders a JSON response with errors for the user' do
        put :update, params: { id: user.id, user: invalid_attributes[:user] }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('error')
      end
    end

    context 'when the user is not found' do
      let(:valid_attributes) do
        {
          user: {
            username: 'updateduser@gmail.com',
            password: 'newpassword',
            employee_id: employee.id
          }
        }
      end

      it 'returns a not found response' do
        put :update, params: { id: 'non-existent-id', user: valid_attributes[:user] }
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include('User not found')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when the user exists' do
      context 'and destroy is successful' do
        it 'destroys the requested user' do
          expect {
            delete :destroy, params: { id: user.id }
          }.to change(User, :count).by(-1)
        end

        it 'returns a no content response' do
          delete :destroy, params: { id: user.id }
          expect(response).to have_http_status(:no_content)
        end
      end

      context 'and destroy fails' do
        before do
          # Simulate a failure in the destroy method
          allow_any_instance_of(User).to receive(:destroy).and_return(false)
          allow_any_instance_of(User).to receive_message_chain(:errors, :full_messages).and_return(['Failed to delete user'])
        end

        it 'does not destroy the user' do
          expect {
            delete :destroy, params: { id: user.id }
          }.not_to change(User, :count)
        end

        it 'returns an unprocessable entity response' do
          delete :destroy, params: { id: user.id }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to include('Failed to delete user')
        end
      end
    end

    context 'when the user is not found' do
      it 'returns a not found response' do
        delete :destroy, params: { id: 'non-existent-id' }
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include('User not found')
      end
    end
  end
end
