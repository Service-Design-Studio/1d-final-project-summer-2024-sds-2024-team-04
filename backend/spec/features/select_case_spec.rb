require 'rails_helper'
require 'selenium-webdriver'

RSpec.feature 'select_case', type: :feature, js: true do

  before(:each) do
    # You might want to add user creation or authentication setup here if needed
  end

  scenario 'Navigating to the case review page' do
    # Visit the dashboard page
    visit 'https://sds-cpf-frontend-kr3vrf23oq-as.a.run.app/dashboard'
    expect(page).to have_current_path('/dashboard')

    # Click on the case with the specified ID
    case_id = '1' # Replace with an actual case ID or parameterize if needed
    find('.dash-case-warp', text: case_id).click

    # Verify that the URL is correct for the case review page
    expect(page).to have_current_path("/auditedcasereview/#{case_id}")

    # Check for specific text content on the case review page
    expected_text = 'Cirteria' # Replace with the actual text you expect
    expected_text = 'Satisfy/Unsatisfy'
    expect(page).to have_content(expected_text)
  end

end
