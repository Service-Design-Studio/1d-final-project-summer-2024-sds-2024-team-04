require 'rails_helper'
require 'selenium-webdriver'

RSpec.feature "Select Case", type: :feature, js: true do
  scenario "Navigate to incomplete case review page" do
    # Step: Visit the dashboard page
    visit 'https://sds-cpf-frontend-kr3vrf23oq-as.a.run.app/dashboard'
    
    # Step: Click the case with the status "In Progress"
    using_wait_time(10) do
        status = 'In Progress'  # Replace with the actual status text used in your test data
        find(:xpath, "//div[contains(@class, 'dash-case-warp') and .//div[contains(text(), '#{status}')]]").click
    end
    # Step: Verify that we are on the case review page for the incomplete case
    expect(page).to have_current_path(/auditedcasereview\/\d+/)

    # Step: Verify that the page contains the line "No audited result!"
    expect(page).to have_content('No audited result!')
  end
end
