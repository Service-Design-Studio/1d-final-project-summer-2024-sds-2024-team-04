Given('I am on the case review page with criteria that I want to override') do
    visit 'https://sds-cpf-frontend-kr3vrf23oq-as.a.run.app/auditedcasereview/1'  # Adjust URL if needed
    # Add any additional setup steps here if necessary
  end
  
  When('I click the "Override Result" button') do
    # Click the button to start the override process
    find('button', text: 'Override Result').click
  end
  
  And('I choose {string} in the row with {string}') do |override_value, criteria_name|
    within(:xpath, "//div[contains(@class, 'radio-wrap') and .//div[contains(text(), '#{criteria_name}')]]") do
      # Find the radio button based on the override_value text
      find(:xpath, ".//div[contains(text(), '#{override_value}')]/input[@type='radio']").click
    end
  end
  
  
  And('I click the "Submit" button') do
    # Click the submit button to finalize the override
    find('button', text: 'Submit').click
  end
  
  Then('I should see {string} with {string}') do |criteria_name, expected_value|
    within(:xpath, "//div[contains(@class, 'result-wrap') and .//div[text()='#{criteria_name}']]") do
      expect(page).to have_content(expected_value)
    end
  end
  
  
  
  And('I should see {string} under "Audit Result"') do |text|
    # Verify that the 'Edited' text is visible on the page
    expect(page).to have_content(text)
  end
  