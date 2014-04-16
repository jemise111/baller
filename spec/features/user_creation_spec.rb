require 'spec_helper'

feature "A user can create an account" do

  background do
    visit '/login'
    click_link 'Create one!'
  end

  scenario "should create an account with valid information" do
    fill_in 'Name', with: 'Dominick Sessler'
    fill_in 'Email', with: 'dominick@sessler.com'
    fill_in 'Password', with: 'qwerty'
    fill_in 'Confirm Password', with: 'qwerty'
    click_button 'Create User'
    expect(page).to have_content('Dominick')
  end

  scenario "should not be able to create an account invalid fields" do
    fill_in 'Email', with: 'dominick@sessler.com'
    fill_in 'Password', with: 'qw'
    fill_in 'Confirm Password', with: 'q'
    click_button 'Create User'
    expect(page).to have_content("Password confirmation doesn't match Password")
    expect(page).to have_content("Password must be at least 5 characters")
    expect(page).to have_content("Name can't be blank")
  end

end
