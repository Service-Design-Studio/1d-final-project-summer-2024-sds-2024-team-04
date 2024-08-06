require 'rails_helper'
require 'selenium-webdriver'

RSpec.feature "Search Overview", type: :feature, js: true do
  scenario "See overview of the team's performance" do
    # Step: Visit the dashboard page
    visit 'https://sds-cpf-frontend-kr3vrf23oq-as.a.run.app/dashboard'
    
    # Explicit wait to ensure the page has loaded and the elements are visible
    using_wait_time(10) do
      expect(page).to have_selector('.dash-text-one', text: 'Total Cases')
      expect(page).to have_selector('.dash-text-one', text: 'Total Audited Cases')
      expect(page).to have_selector('.dash-text-one', text: 'Average Score')
    end
  end
end
