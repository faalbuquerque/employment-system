require 'rails_helper'

feature 'Collaborator creates company and registers' do
  scenario 'successfully, register first as admin' do
    visit root_path

    click_on 'Empresa'
    click_on 'Sign up'

    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'

    expect(page).to have_content 'Boas vindas test@test.com'
    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).to have_content 'Acesso de Administrador'
    expect(page).to have_content 'Empresa: test'
    expect(page).to have_link 'Atualizar Empresa'
  end

  scenario 'successfully, register others non-admins' do
    company = Company.create!(name: 'test')
    user_admin = Collaborator.create!(email: 'test_admin@test.com', 
                                      password: 'password', company: company)
    non_admin = Collaborator.create!(email: 'test_standard@test.com',
                                     password:'password', company: company)

    login_as non_admin, scope: :collaborator
    visit root_path

    expect(page).to have_content 'Empresa: test'
    expect(page).to have_content 'Acesso de Colaborador'
    expect(page).to_not have_content 'Acesso de Administrador'
    expect(page).to_not have_link 'Atualizar Empresa'
  end

  scenario 'is already registered' do
    company = Company.create!(name: 'teste')
    Collaborator.create!(email: 'test@test.com', password: 'password',
                         company: company)

    visit root_path

    click_on 'Empresa'
    click_on 'Sign up'

    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'password2'
    fill_in 'Password confirmation', with: 'password2'
    click_on 'Sign up'

    expect(page).to have_content 'Email já está em uso'
  end
end
