Given('I am on the dashboard page with the search bar with an invalid condition') do
  visit 'https://sds-cpf-frontend-kr3vrf23oq-as.a.run.app/dashboard'
  # Assuming that an invalid condition means setting up the search bar with some initial state
  # If there's a specific setup needed for "invalid condition", add it here
end

When('I choose the ID category in the dropdown menu') do
  find('select.search-dropdown').select('ID')
end

When('I type in the wrong ID {string} in the search bar') do |search_term|
  find('input.search-bar').set(search_term)
end

Then('I should see no cases') do
  # Ensure no cases are displayed
  expect(page).to have_no_selector('.dash-case-warp')
end
