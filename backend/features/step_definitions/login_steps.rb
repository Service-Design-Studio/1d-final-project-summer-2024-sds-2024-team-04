Given('a user with email {string} and password {string} exists') do |email, password|
    # Using the API to create the user
    User.create(username: email, password: password, employee_id: 'E12345')
  end
  
  Given('I am on the login page') do
    visit 'http://localhost:3001/login'
    expect(page).to have_button('Login')  # Verify that the button with text 'Login' is present on the page
  end
  
  When('I fill in {string} with {string}') do |field, value|
    fill_in field, with: value
  end
  
  When('I press {string}') do |button|
    click_button button
  end
  
  Then('I should see a Dashboard') do
    expect(page).to have_content('Dashboard')
  end
  
  Then('I should see an error message') do
    expect(page).to have_content('Wrong Username and Password. Try again !')
  end