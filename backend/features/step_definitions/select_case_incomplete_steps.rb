  Given('I am on the dashboard page with an incomplete case') do
      visit 'https://sds-cpf-frontend-kr3vrf23oq-as.a.run.app/dashboard'  # Adjust the URL if needed
    end
    
    When('I click the case with status {string}') do |status|
      # Find the case with the given status and click it
      find(:xpath, "//div[contains(@class, 'dash-case-warp') and .//div[contains(text(), '#{status}')]]").click
    end
    
    Then('I should be on the case review page for the incomplete case') do
      # Assuming the path includes some identifier for the case
      expect(page).to have_current_path(/auditedcasereview\/\d+/)
    end
    
    Then('I should see the line {string}') do |text|
      # Check for the presence of the text indicating no audited results
      expect(page).to have_content(text)
    end
    