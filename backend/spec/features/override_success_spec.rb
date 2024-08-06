require 'rails_helper'
require 'selenium-webdriver'

RSpec.feature "Override Criteria", type: :feature, js: true do
  scenario "Override criteria result" do
    # Step: Visit the case review page with criteria
    visit 'https://sds-cpf-frontend-kr3vrf23oq-as.a.run.app/auditedcasereview/1'
    
    # Step: Click the "Override Result" button
    find('button', text: 'Override Result').click
    
    # Step: Choose "Unsatisfy" in the row with "Criteria8"
    within(:xpath, "//div[contains(@class, 'radio-wrap') and .//div[contains(text(), 'Criteria8')]]") do
      find(:xpath, ".//div[contains(text(), 'Unsatisfy')]/input[@type='radio']").click
    end

    # Step: Click the "Submit" button
    find('button', text: 'Submit').click

    # Step: Verify "Criteria8" with "Unsatisfy" is visible
    within(:xpath, "//div[contains(@class, 'result-wrap') and .//div[text()='Criteria8']]") do
      expect(page).to have_content('Unsatisfy')
    end

    # Step: Verify "Edited" is visible under "Audit Result"
    expect(page).to have_content('Edited')
  end
end
