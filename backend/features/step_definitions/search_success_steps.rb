Given('I am on the dashboard page with the search bar with an valid condition') do
    visit 'https://sds-cpf-frontend-kr3vrf23oq-as.a.run.app/dashboard'
  end
  
  When('I choose ID in the dropdown menu') do
    find('select.search-dropdown').select('ID')
  end
  
  When('I type in the correct ID {string} in the search bar') do |search_term|
    find('input.search-bar').set(search_term)
  end
  
  Then('I should only see cases with the ID {string}') do |case_id|
    cases = all(:xpath, "//div[contains(@class, 'dash-case-warp')]")
    cases.each do |case_element|
      expect(case_element).to have_text(case_id)
    end
  end
  