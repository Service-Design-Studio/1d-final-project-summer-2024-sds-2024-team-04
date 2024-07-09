Given("I am on the new employee form") do
  visit "http://localhost:3000/employees/new"
end

When("I fill in the employee details") do |table|
  data = table.rows_hash
  fill_in 'employee_first_name', with: data['First Name']
  fill_in 'employee_last_name', with: data['Last Name']
  fill_in 'employee_email', with: data['Email']
  fill_in 'employee_contact_number', with: data['Contact Number']
  fill_in 'employee_address', with: data['Address']
  fill_in 'employee_pincode', with: data['Pincode']
  fill_in 'employee_city', with: data['City']
  fill_in 'employee_state', with: data['State']
  fill_in 'employee_date_of_birth', with: data['Date of Birth']
  fill_in 'employee_date_of_hiring', with: data['Date of Hiring']
  fill_in 'employee_role', with: data['Role']
end

# Step to submit the form
And("I submit the form") do
  click_button "Submit"
end

# Step to verify the employee details are displayed correctly
Then("I should see the employee details on the employee list") do |table|
  data = table.rows_hash
  expect(page).to have_content(data['First Name'])
  expect(page).to have_content(data['Last Name'])
  expect(page).to have_content(data['Email'])
  expect(page).to have_content(data['Contact Number'])
  expect(page).to have_content(data['Address'])
  expect(page).to have_content(data['Pincode'])
  expect(page).to have_content(data['City'])
  expect(page).to have_content(data['State'])
  expect(page).to have_content(data['Date of Birth'])
  expect(page).to have_content(data['Date of Hiring'])
  expect(page).to have_content(data['Role'])
end

# Step to fill in invalid employee details based on provided table data
When("I fill in invalid employee details") do |table|
  data = table.transpose.raw
  header = data.shift
  field_mappings = {
    "First Name" => :first_name,
    "Last Name" => :last_name,
    "Email" => :email,
    "Contact Number" => :contact_number,
    "Address" => :address,
    "Pincode" => :pincode,
    "City" => :city,
    "State" => :state,
    "Date of Birth" => :date_of_birth,
    "Date of Hiring" => :date_of_hiring,
    "Role" => :role
  }

  data.each do |row|
    field = field_mappings[row[0]]
    value = row[1]
    fill_in field, with: value unless field.nil? # Skip filling if field is nil (error message row)
  end
end

# Step to verify errors for each invalid field are displayed
Then("I should see errors for each invalid field") do |table|
  data = table.transpose.raw
  header = data.shift
  error_messages = data.flatten

  error_messages.each do |error_message|
    expect(page).to have_content(error_message)
  end
end
