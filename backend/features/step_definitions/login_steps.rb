Given('a user with email {string} and password {string} exists') do |email, password|
    # Using the API to create the user
    user_params = {
      user: {
        username: email,
        password: password,
        employee_id: 'E12345'
      }
    }
    page.driver.post '/api/v1/users', user_params
  end
  
  Given('I am on the login page') do
    visit new_user_session_path
  end
  
  When('I fill in {string} with {string}') do |field, value|
    fill_in field, with: value
  end
  
  When('I press {string}') do |button|
    click_button button
  end
  
  Then('I should see {string}') do |message|
    expect(page).to have_content(message)
  end
  