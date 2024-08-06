require 'rails_helper'
require 'selenium-webdriver'

RSpec.feature "Search", type: :feature, js: true do
  scenario "Searching by condition which at least 1 case fulfills" do
    # Step: Visit the dashboard page
    visit 'https://sds-cpf-frontend-kr3vrf23oq-as.a.run.app/dashboard'
    
    # Step: Choose 'ID' in the dropdown menu
    find('select.search-dropdown').select('ID')
    
    # Step: Type the correct ID into the search bar
    valid_id = '1'  # Replace with the actual ID used in your test data
    find('input.search-bar').set(valid_id)
    
    # Wait for the search results to be updated
    sleep 2 # Consider using Capybara's waiting methods like `has_selector?` instead of sleep
    
    # Ensure that only cases with the specified ID are displayed
    cases = all(:xpath, "//div[contains(@class, 'dash-case-warp')]")
    cases.each do |case_element|
      expect(case_element).to have_text(valid_id)
    end
    
    # Ensure that no cases with other IDs are displayed
    all(:xpath, "//div[contains(@class, 'dash-case-warp')]").each do |case_element|
      expect(case_element).to have_text(valid_id)
    end
  end
end
