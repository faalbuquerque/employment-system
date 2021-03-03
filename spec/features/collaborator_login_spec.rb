require 'rails_helper'

feature 'Collaborator login' do
  scenario 'successfully, login admin' do
    company = Company.create!(name: 'test')
    admin = Collaborator.create!(email: 'test@test.com', password: 'password', 
                                 company: company)

    login_as admin, scope: :collaborator
    visit collaborators_path

    expect(page).to have_content 'Boas vindas test@test.com'
  end

  scenario 'successfully, login non-admins' do
    company = Company.create!(name: 'test')
    user_admin = Collaborator.create!(email: 'test_admin@test.com', password: 'password',
                                      company: company)
    non_admin = Collaborator.create!(email: 'test_non-admin@test.com', password: 'password',
                                     company: company)

    login_as non_admin, scope: :collaborator
    visit root_path

    expect(page).to have_content 'test_non-admin@test.com'
  end

  scenario 'logout' do
    company = Company.create!(name: 'test')
    Collaborator.create!(email: 'test@test.com', password: 'password', 
                         company: company)

    visit collaborators_path
    click_on 'Empresa'

    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'

    click_on 'Logout'

    expect(page).to have_content 'Saiu com sucesso.'
    expect(page).to_not have_content 'Boas vindas test@teste.com'
    expect(page).to_not have_content 'Empresa: teste'
  end

  scenario 'not valid when email is blank' do
    company = Company.create!(name:'teste')
    collaborator = Collaborator.new(email:'',
                                    password:'123456',
                                    company: company)

    expect(collaborator.valid?).to_not eq(true)
  end
end
