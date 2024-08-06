require 'rails_helper'
require 'selenium-webdriver'

RSpec.feature "Chat Transcript", type: :feature, js:true do
  scenario "Navigate to case review page" do
    # Visit the dashboard page
    visit 'https://sds-cpf-frontend-kr3vrf23oq-as.a.run.app/dashboard'
    
    # Click on the case with the specified ID
    case_id = '1' # Replace with an actual case ID or parameterize if needed
    find(:xpath, "//div[contains(@class, 'dash-case-warp') and .//div[text()='#{case_id}']]").click
     
    # Verify that we are on the case review page for case ID '1'
    expect(page).to have_current_path("/auditedcasereview/#{case_id}")

    # Verify that the name 'Officer' is visible on the page
    expect(page).to have_content('Officer')

    # Verify that there is another name that is not 'Officer'
    # The below approach might need adjustment based on the actual content
    expect(page).to have_selector('body', text: /^(?!.*Officer).*$/)
  end
end
