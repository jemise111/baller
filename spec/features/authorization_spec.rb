require 'spec_helper'

def sign_in(email, password)
  visit '/login'
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'login'
end

feature "A user can sign in" do

  background { User.create!(name: 'Jesse Sessler',
                       email: "jesse@sessler.com",
                       password: "qwerty",
                       password_confirmation: "qwerty") }

  scenario "should sign in the user given a valid username and password" do
    sign_in("jesse@sessler.com", "qwerty")
    expect(page).to have_content('Find A Court.')
  end

  scenario "should not sign in a user with an invalid username and password" do
    sign_in("jesse@sessler.com", "wrong")
    expect(page).to have_content("Invalid email and/or password")
  end
end
