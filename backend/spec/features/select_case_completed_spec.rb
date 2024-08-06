require 'rails_helper'
require 'selenium-webdriver'

RSpec.feature "Select Case", type: :feature, js: true do
  scenario "Navigate to completed case review page" do
    # Step: Visit the dashboard page
    visit 'https://sds-cpf-frontend-kr3vrf23oq-as.a.run.app/dashboard'
    
    # Step: Click the case with the specified ID
    case_id = '1'  # Replace with the actual case ID used in your test data
    find(:xpath, "//div[contains(@class, 'dash-case-warp') and .//div[text()='#{case_id}']]").click

    # Step: Verify that we are on the case review page for the case ID
    expect(page).to have_current_path("/auditedcasereview/#{case_id}")

    # Step: Verify that the page contains the text "Criteria"
    expect(page).to have_content('Criteria')

    # Step: Verify that the page contains the text "Satisfy/Unsatisfy"
    expect(page).to have_content('Satisfy/Unsatisfy')
  end
end
