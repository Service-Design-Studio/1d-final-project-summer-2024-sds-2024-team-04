# spec/features/import_chat_transcripts_spec.rb

require 'rails_helper'

RSpec.feature "Importing Chat Transcripts via CSV", type: :feature do
  background do
    visit 'http://localhost:3000/chat_transcripts/import'
  end

  scenario "Import a valid CSV file" do
    csv_path = Rails.root.join('spec', 'features', 'valid_chat_transcripts.csv')
    attach_file('file', csv_path)
    click_button 'Import CSV'
    
    expect(page).to have_content("CSV file has been successfully uploaded.")
    
    visit "http://localhost:3000/chat_transcripts"
    
    within('table tbody') do
      expect(page).to have_selector('tr', minimum: 1)
      expect(page).to have_css('td', minimum: 10)  # Adjust based on the number of columns
    end
  end

  scenario "Import an invalid CSV file" do
    invalid_csv_path = Rails.root.join('spec', 'features', 'invalid_chat_transcripts.csv')
    attach_file('file', invalid_csv_path)
    click_button 'Import CSV'
    
    expect(page).to have_content("Error importing CSV: CSV contains rows with missing required fields.")
    # Add more specific error message checks based on your application's validation logic
  end
end
