require 'rails_helper'

feature 'Collaborator creates account with company email' do
  scenario 'successfully, first collaborator as admin' do
    visit root_path

    click_on 'Login'
    click_on 'Sign up'

    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'

    expect(page).to have_content('Boas vindas test@test.com')
    expect(page).to have_content('Login efetuado com sucesso')
    expect(page).to have_content('Acesso de Administrador')
    expect(page).to have_content('Empresa: test')
    expect(page).to have_link('Preencher informações da Empresa')
  end

  scenario 'successfully, others non-admins collaborators' do
    company = Company.create!(name: 'test')
    user_admin = Collaborator.create!(email: 'test_admin@test.com', password: 'password', company: company)
    non_admin = Collaborator.create!(email: 'test_standard@test.com', password: 'password', company: company)

    login_as non_admin, scope: :collaborator
    visit root_path

    expect(page).to have_content('Empresa: test')
    expect(page).to have_content('Acesso de Colaborador')
    expect(page).to_not have_content('Acesso de Administrador')
    expect(page).to_not have_link('Preencher informações da Empresa')
  end

  scenario 'is already registered' do
    company = Company.create!(name: 'teste')
    Collaborator.create!(email: 'test@test.com', password: 'password', company: company)

    visit root_path

    click_on 'Login'
    click_on 'Sign up'

    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'password2'
    fill_in 'Password confirmation', with: 'password2'
    click_on 'Sign up'

    expect(page).to have_content('Email já está em uso')
  end

  scenario 'blank fields' do
    visit root_path

    click_on 'Login'
    click_on 'Sign up'

    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    fill_in 'Password confirmation', with: ''
    click_on 'Sign up'

    expect(page).to have_content('Email não pode ficar em branco')
    expect(page).to have_content('Password não pode ficar em branco')
  end

  scenario 'button logout' do
    visit root_path

    click_on 'Login'
    click_on 'Sign up'

    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'
    click_on 'Logout'

    expect(page).to have_content('Saiu com sucesso.')
    expect(page).to_not have_content('Boas vindas test@teste.com')
    expect(page).to_not have_content('Empresa: teste')
  end
end
