Given('I am on the dashboard page') do
    visit 'http://localhost:3001/dashboard'  
  end
  
  When('I click the case with ID {string}') do |case_id|
    find('.dash-case-warp', text: case_id).click
  end
  
  Then('I should be on the case review page for case ID {string}') do |case_id|
    expect(page).to have_current_path("/auditedcasereview/#{case_id}")
  end
  
  Then('I should see {string}') do |text|
    expect(page).to have_content(text)
  end
  