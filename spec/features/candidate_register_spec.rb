require 'rails_helper'

feature 'Candidate Register' do
  scenario 'successfully' do
    visit root_path
    click_on 'Candidato'
    click_on 'Sign up'

    fill_in 'Email', with: 'test@test.com'
    fill_in 'Name',	with: 'Tester' 
    fill_in 'Cpf', with: '33333333333'
    fill_in 'Telephone', with: '11 9 56565666'
    fill_in 'Bio', with: 'Estudante de testes'

    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'

    expect(page).to  have_content 'Login efetuado com sucesso.'
    expect(page).to  have_content 'Logout'
  end

  scenario 'blank fields' do
    visit root_path
    click_on 'Candidato'
    click_on 'Sign up'

    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    fill_in 'Password confirmation', with: ''
    click_on 'Sign up'

    expect(page).to  have_content 'Email não pode ficar em branco'
    expect(page).to  have_content 'Password não pode ficar em branco'
  end
end
