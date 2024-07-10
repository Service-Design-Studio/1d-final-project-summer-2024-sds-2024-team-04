require 'rails_helper'

RSpec.feature "Employee Management", type: :feature do
  scenario "Creating a new employee" do
    visit "http://localhost:3000/employees/new"
    
    fill_in 'employee_first_name', with: 'John'
    fill_in 'employee_last_name', with: 'Doe'
    fill_in 'employee_email', with: 'john.doe@example.com'
    fill_in 'employee_contact_number', with: '9876543210'
    fill_in 'employee_address', with: '123 Main St'
    fill_in 'employee_pincode', with: '12345'
    fill_in 'employee_city', with: 'Anytown'
    fill_in 'employee_state', with: 'AnyState'
    fill_in 'employee_date_of_birth', with: '1990-01-01'
    fill_in 'employee_date_of_hiring', with: '2024-07-08'
    fill_in 'employee_role', with: 'Agent'
    
    click_button "Submit"
    
    expect(page).to have_content('John')
    expect(page).to have_content('Doe')
    expect(page).to have_content('john.doe@example.com')
    expect(page).to have_content('9876543210')
    expect(page).to have_content('123 Main St')
    expect(page).to have_content('12345')
    expect(page).to have_content('Anytown')
    expect(page).to have_content('AnyState')
    expect(page).to have_content('1990-01-01')
    expect(page).to have_content('2024-07-08')
    expect(page).to have_content('Agent')
  end

  scenario "Validating new employee form" do
    visit "http://localhost:3000/employees/new"

    click_button "Submit"

    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Contact number can't be blank")
    expect(page).to have_content("Address can't be blank")
    expect(page).to have_content("Pincode can't be blank")
    expect(page).to have_content("City can't be blank")
    expect(page).to have_content("State can't be blank")
    expect(page).to have_content("Date of birth can't be blank")
    expect(page).to have_content("Date of hiring can't be blank")
    expect(page).to have_content("Role can't be blank")
  end
end