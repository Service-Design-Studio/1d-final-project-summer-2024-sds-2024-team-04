require 'rails_helper'

RSpec.feature "Employee Management", type: :feature do
  scenario "Creating a new employee" do
    visit new_employee_path
    
    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Doe'
    fill_in 'Email', with: 'john.doe@example.com'
    fill_in 'Contact Number', with: '9876543210'
    fill_in 'Address', with: '123 Main St'
    fill_in 'Pincode', with: '12345'
    fill_in 'City', with: 'Anytown'
    fill_in 'State', with: 'AnyState'
    fill_in 'Date of Birth', with: '1990-01-01'
    fill_in 'Date of Hiring', with: '2024-07-08'
    select 'Manager', from: 'Role'
    
    click_button 'Submit'
    
    expect(page).to have_content 'Employee Details'
    expect(page).to have_content 'Name: John Doe'
    expect(page).to have_content 'Email: john.doe@example.com'
    expect(page).to have_content 'Contact Number: 9876543210'
    expect(page).to have_content 'Address: 123 Main St, Anytown, AnyState, 12345'
    expect(page).to have_content 'Date of Birth: 1990-01-01'
    expect(page).to have_content 'Date of Hiring: 2024-07-08'
    expect(page).to have_content 'Role: Manager'
  end

  scenario "Validating new employee form" do
    visit new_employee_path
    
    click_button 'Submit'
    
    expect(page).to have_content "First Name can't be blank"
    expect(page).to have_content "Last Name can't be blank"
    expect(page).to have_content "Email is invalid"
    expect(page).to have_content "Contact Number is invalid"
    expect(page).to have_content "Address can't be blank"
    expect(page).to have_content "Pincode can't be blank"
    expect(page).to have_content "City can't be blank"
    expect(page).to have_content "State can't be blank"
    expect(page).to have_content "Date of Birth must be before Date of Hiring"
    expect(page).to have_content "Role can't be blank"
  end
end
