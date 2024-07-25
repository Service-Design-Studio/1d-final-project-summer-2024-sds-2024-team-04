require 'rails_helper'

RSpec.describe Api::V1::EmployeesController, type: :controller do
  let!(:role) { Role.create!(name: 'Test Role') }
  let!(:employee) { Employee.create!(name: 'Test Employee', email: 'test@example.com', contact_no: '1234567890', role: role) }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
      expect(JSON.parse(response.body)['data'].size).to eq(1)
    end

    it "returns all employees" do
      get :index
      json_response = JSON.parse(response.body)
      names = json_response['data'].map { |employee| employee['attributes']['name'] }
      expect(names).to contain_exactly('Test Employee')
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: employee.id }
      expect(response).to be_successful
    end

    it "returns the correct employee" do
      get :show, params: { id: employee.id }
      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['name']).to eq('Test Employee')
    end

    it "returns not found for a non-existent employee" do
      get :show, params: { id: 9999 }
      expect(response).to have_http_status(:not_found)
      expect(response.body).to include('Employee not found')
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) do
        {
          employee: {
            name: 'New Employee',
            email: 'new@example.com',
            contact_no: '0987654321',
            role_id: role.id
          }
        }
      end

      it 'creates a new Employee' do
        expect {
          post :create, params: valid_attributes
        }.to change(Employee, :count).by(1)
      end

      it 'renders a JSON response with the new employee' do
        post :create, params: valid_attributes
        expect(response).to be_successful
        expect(response.body).to include('New Employee')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          employee: {
            name: nil,
            email: nil,
            contact_no: nil,
            role_id: nil
          }
        }
      end

      it 'does not create a new Employee' do
        expect {
          post :create, params: invalid_attributes
        }.to change(Employee, :count).by(0)
      end

      it 'renders a JSON response with errors for the new employee' do
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
          employee: {
            name: 'Updated Employee',
            email: 'updated@example.com',
            contact_no: '1122334455',
            role_id: role.id
          }
        }
      end

      it 'updates the requested employee' do
        put :update, params: { id: employee.id, employee: valid_attributes[:employee] }
        employee.reload
        expect(employee.name).to eq('Updated Employee')
      end

      it 'renders a JSON response with the updated employee' do
        put :update, params: { id: employee.id, employee: valid_attributes[:employee] }
        expect(response).to be_successful
        expect(response.body).to include('Updated Employee')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          employee: {
            name: nil,
            email: nil,
            contact_no: nil,
            role_id: nil
          }
        }
      end

      it 'does not update the employee' do
        put :update, params: { id: employee.id, employee: invalid_attributes[:employee] }
        employee.reload
        expect(employee.name).to eq('Test Employee')
      end

      it 'renders a JSON response with errors for the employee' do
        put :update, params: { id: employee.id, employee: invalid_attributes[:employee] }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('error')
      end
    end
  end

  describe "DELETE #destroy" do
    context 'when the employee exists and is successfully destroyed' do
      it 'destroys the requested employee' do
        expect {
          delete :destroy, params: { id: employee.id }
        }.to change(Employee, :count).by(-1)
      end

      it 'returns a no content response' do
        delete :destroy, params: { id: employee.id }
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the employee exists but destroy fails' do
      before do
        allow_any_instance_of(Employee).to receive(:destroy).and_return(false)
        allow_any_instance_of(Employee).to receive_message_chain(:errors, :full_messages).and_return(['Failed to delete'])
      end

      it 'does not destroy the requested employee' do
        expect {
          delete :destroy, params: { id: employee.id }
        }.not_to change(Employee, :count)
      end

      it 'renders a JSON response with errors for the employee' do
        delete :destroy, params: { id: employee.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Failed to delete')
      end
    end

    context 'when the employee is not found' do
      it 'returns a not found response' do
        delete :destroy, params: { id: 9999 }
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include('Employee not found')
      end
    end
  end
end
