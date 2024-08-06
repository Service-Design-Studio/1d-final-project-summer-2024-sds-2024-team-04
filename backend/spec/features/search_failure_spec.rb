require 'rails_helper'
require 'selenium-webdriver'

RSpec.feature "Search", type: :feature, js: true do
  scenario "Searching by condition which no cases fulfill" do
    # Step: Visit the dashboard page
    visit 'https://sds-cpf-frontend-kr3vrf23oq-as.a.run.app/dashboard'
    
    # Step: Choose the ID category in the dropdown menu
    find('select.search-dropdown').select('ID')
    
    # Step: Type in the wrong ID in the search bar
    find('input.search-bar').set('10')
    
    # Step: Verify that no cases are displayed
    using_wait_time(10) do
      expect(page).to have_no_selector('.dash-case-warp')
    end
  end
end
