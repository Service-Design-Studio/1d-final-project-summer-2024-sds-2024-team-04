Given('I am on the dashboard for all officers under my team') do
    visit 'https://sds-cpf-frontend-kr3vrf23oq-as.a.run.app/dashboard'  # Adjust the URL if needed
  end
  
  Then('I should see the {string}, {string} and {string} text in the dashboard') do |text1, text2, text3|
    expect(page).to have_selector('.dash-text-one', text: text1)
    expect(page).to have_selector('.dash-text-one', text: text2)
    expect(page).to have_selector('.dash-text-one', text: text3)
  end
  