# frozen_string_literal: true
require 'rails_helper'

feature 'User sign in', type: :feature do
  let(:login_page) { LoginPage.new }
  let(:user) { create(:user) }

  before do
    login_page.load
  end

  scenario 'Successfully sign in' do
    within login_page.login_form do
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Sign in'
    end
    expect(login_page.flash_success).to have_content('Signed in successfully.')
    expect(login_page.navigation).to have_content("Hi, #{user.name}")
  end

  scenario 'Gets an error when credentials are invalid' do
    within login_page.login_form do
      fill_in 'user[email]', with: 'invalid@user.com'
      fill_in 'user[password]', with: 'password'
      click_button 'Sign in'
    end
    expect(login_page.flash_error).to have_content('Invalid Email or password.')
  end

  scenario 'Has reset password link' do
    expect(login_page).to have_reset_password_link
  end
end
