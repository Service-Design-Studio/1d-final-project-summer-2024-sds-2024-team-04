require 'rails_helper'

RSpec.describe Api::V1::UnauditedCasesController, type: :controller do
  let!(:role) { Role.create!(name: 'Test Role') }
  let!(:employee) { Employee.create!(name: 'Test Employee', email: 'test@example.com', contact_no: '1234567890', role: role) }
  let!(:case_record) { Case.create!(messagingSection: 'Test Message Section', employee: employee) }
  let!(:unaudited_case) { Case.create!(messagingSection: 'Test Message Section', phoneNumber: '123-456-7890', topic: 'Test Topic', status: 0, employee: employee) }
  let!(:chat_transcript) { ChatTranscript.create!(messagingUser: 'Test User', message: 'Test Message', case: unaudited_case) }
  let!(:other_case) { Case.create!(messagingSection: 'Other Message Section', phoneNumber: '098-765-4321', topic: 'Other Topic', status: 1, employee: employee) }

  describe "GET #index" do
    before { get :index }

    it "returns a success response" do
      expect(response).to be_successful
    end 

    it "returns only cases with status 0" do
      json_response = JSON.parse(response.body)
      data = json_response['data']  # This is an array of case objects

      expect(data).to be_an(Array)
      expect(data.map { |case_data| case_data['attributes']['status'] }).to all(eq(0))
    end
    

    it "includes the chat_transcript relationship" do
      json_response = JSON.parse(response.body)
      #puts response.body
      included = json_response['included']

      expect(included).to be_an(Array)
      expect(included.any? { |i| i['type'] == 'chat_transcript' }).to be(true)

      # Verify the content of the chat_transcript
      chat_transcript_included = included.find { |i| i['type'] == 'chat_transcript' }
      expect(chat_transcript_included['attributes']['message']).to eq('Test Message')
    end

    
  end
end
