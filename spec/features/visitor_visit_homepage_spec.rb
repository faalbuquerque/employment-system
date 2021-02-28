require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    visit root_path
    expect(page).to have_content I18n.t(:employment_system_title)
  end
end
