Given('I am on the dashboard page') do
    visit 'https://sds-cpf-frontend-kr3vrf23oq-as.a.run.app/dashboard'  
  end
  
  When('I click the case with ID {string}') do |case_id|
    find(:xpath, "//div[contains(@class, 'dash-case-warp') and .//div[text()='#{case_id}']]").click
  end
  
  Then('I should be on the case review page for case ID {string}') do |case_id|
    expect(page).to have_current_path("/auditedcasereview/#{case_id}")
  end
  
  Then('I should see {string}') do |text|
    expect(page).to have_content(text)
  end
    