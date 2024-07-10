# features/step_definitions/import_steps.rb

Given('I am on the import CSV form') do
    visit 'http://localhost:3000/chat_transcripts/import'
    #puts page.html
  end

  When("I upload a csv file") do
    # Adjust the file path according to your setup
    csv_path = Rails.root.join('spec', 'features', 'valid_chat_transcripts.csv')
    attach_file('file', csv_path)
    click_button "Import CSV"
  end

  # Verify CSV acceptance
  Then("the CSV file should be accepted") do
    # Add your verification steps here
    expect(page).to have_content("CSV file has been successfully uploaded.")
  end

  # Visit the chat transcripts page
  When("I visit the chat transcripts page") do
    visit "http://localhost:3000/chat_transcripts"
  end

  Then('I should see the chat transcript details on the chat transcript list') do
    puts page.html
    within('table tbody') do
      expect(page).to have_selector('tr', minimum: 1)
      expect(page).to have_css('td', minimum: 10)  # Adjust based on the number of columns
    end
  end

#   # Invalid case
#   When("I upload an invalid CSV file") do
#     invalid_csv_path = Rails.root.join('spec', 'features', 'invalid_chat_transcripts.csv')
#     attach_file('file', invalid_csv_path)  # Adjust path to your invalid CSV file
#     click_button 'Import CSV'
#   end

#   Then("I should see error messages indicating the invalid chat transcripts") do
#     expect(page).to have_content("Invalid CSV file format")  # Example error message for invalid format
#     # Add more specific error message checks based on your application's validation logic
#   end