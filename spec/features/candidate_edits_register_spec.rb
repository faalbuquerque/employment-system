require 'rails_helper'

feature 'Candidate edits register' do
  scenario 'successfuly' do
    candidate = Candidate.create!(email: 'candidate@test.com', name: 'Tester',
                      cpf: '33333333333', telephone: '11922222222',
                      bio: 'Testando as coisas', password: 'password')

    login_as candidate, scope: :candidate

    visit candidates_path
    click_on 'Editar Perfil'

    fill_in 'Email', with: 'candidate@test.com'
    fill_in 'Cpf', with: '222222222-22'
    fill_in 'Telephone', with: '11 9 56565666'
    fill_in 'Bio', with: 'Estudante de testes'
    fill_in 'Current password', with: 'password'
    click_on 'Update'

    expect(page).to  have_content 'Sua conta foi atualizada com sucesso.'
  end

  scenario 'blank fields' do
    candidate = Candidate.create!(email: 'candidate@test.com', name: 'Tester',
                                  cpf: '33333333333', telephone: '11922222222',
                                  bio: 'Testando as coisas', password: 'password')

    login_as candidate, scope: :candidate
    visit candidates_path

    click_on 'Editar Perfil'

    fill_in 'Email', with: ''
    fill_in 'Name', with: ''
    fill_in 'Cpf', with: ''
    fill_in 'Telephone', with: ''
    fill_in 'Bio', with: ''
    fill_in 'Current password', with: 'password'
    click_on 'Update'

    expect(page).to  have_content 'Não foi possível salvar candidate'
    expect(page).to  have_content 'Name não pode ficar em branco'
    expect(page).to  have_content 'Cpf não pode ficar em branco'
    expect(page).to  have_content 'Telephone não pode ficar em branco'
    expect(page).to  have_content 'Bio não pode ficar em branco'
  end
end
