require 'rails_helper'

feature 'Candidate Login' do
  scenario 'successfully' do
    Candidate.create!(email: 'candidate@test.com', name: 'Tester', 
                      cpf: '33333333333', telephone: '11922222222', 
                      bio: 'Testando as coisas',password: 'password')

    visit root_path
    click_on 'Candidato'

    fill_in 'Email', with: 'candidate@test.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'

    expect(page).to  have_content 'Login efetuado com sucesso!'
    expect(page).to  have_content 'Logout'
  end

  scenario 'blank fields' do
    visit root_path
    click_on 'Candidato'

    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    click_on 'Log in'

    expect(page).to  have_content 'Email ou senha inválida.'
  end
end
