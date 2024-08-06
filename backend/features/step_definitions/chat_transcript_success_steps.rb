Given('I am on the dashboard page with a case that has a chat transcript') do
    visit 'https://sds-cpf-frontend-kr3vrf23oq-as.a.run.app/dashboard'  # Adjust the URL if needed
  end
  
  When('I click the case with ID {string} that has a chat transcript') do |case_id|
    # Find the case with the given ID and click it
    find(:xpath, "//div[contains(@class, 'dash-case-warp') and .//div[text()='#{case_id}']]").click
  end
  
  Then('I should be on the case review page for case ID {string} that has a chat transcript') do |case_id|
    # Assuming the path includes the case ID
    expect(page).to have_current_path("/auditedcasereview/#{case_id}")
  end
  
  Then('I should see the name {string}') do |name|
    # Check that the specified name is visible on the page
    expect(page).to have_content(name)
  end
  
  Then('I should see another name that is not {string}') do |excluded_name|
    # Ensure that there is another name present on the page that is not the excluded name
    within('body') do
      expect(page).to have_content(/(?!#{excluded_name})\b\w+\b/)
    end
  end
  