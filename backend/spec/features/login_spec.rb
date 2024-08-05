require 'rails_helper'
require 'selenium-webdriver'

RSpec.feature 'Login', type: :feature, js: true do
  # Create a user before running the tests
  before(:each) do
    # Make sure to use `let` or `let!` to create user data before tests run
    @user = User.create(username: 'myo@gmail.com', password: '012345', employee_id: 'E12345')
  end

  scenario 'Successful login with valid credentials' do
    # Visit the login page
    visit '/login' # Capybara is configured to use https://sds-cpf-frontend-kr3vrf23oq-as.a.run.app
    save_and_open_page # This should show the React login page if everything is correct
    expect(page).to have_button('Login')

    # Fill in the form fields
    fill_in 'Username', with: 'myo@gmail.com'
    fill_in 'Password', with: '012345'

    # Click the login button
    click_button 'Login'

    # Expect to see the Dashboard after successful login
    expect(page).to have_content('Dashboard')
  end

  scenario 'Unsuccessful login with invalid credentials' do
    # Visit the login page
    visit 'https://sds-cpf-frontend-kr3vrf23oq-as.a.run.app/login'

    # Fill in the form fields with invalid credentials
    fill_in 'Username', with: 'wrongemail@example.com'
    fill_in 'Password', with: 'wrongpassword'

    # Click the login button
    click_button 'Login'

    # Expect to see an error message after unsuccessful login
    expect(page).to have_content('Wrong Username and Password. Try again !')
  end
end
