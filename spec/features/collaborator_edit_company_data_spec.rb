require 'rails_helper'

feature 'Collaborator edit company data' do
  scenario 'successfully' do
    company = Company.create!(name: 'teste')
    admin = Collaborator.create!(email: 'other@test.com', password: 'password', 
                                 company: company, admin: 1)

    login_as admin, scope: :collaborator
    visit collaborators_path
    
    click_on 'Atualizar Empresa'

    fill_in 'Nome', with: 'Empresa Teste'
    fill_in 'Upload de imagem', with: 'imagem@link.com'
    fill_in 'Endereço', with: 'Rua lalala, 11'
    fill_in 'CNPJ', with: '32197584871'
    fill_in 'Site', with: 'http://teste.com.br'
    click_on 'Atualizar Company'

    expect(page).to have_content 'Voltar'
    expect(page).to have_content 'Empresa Test'
    expect(page).to have_content 'imagem@link.com'
    expect(page).to have_content 'Rua lalala, 11'
    expect(page).to have_content '32197584871'
    expect(page).to have_content 'teste.com.br'
  end

  scenario 'name field blank' do
    company = Company.create!(name: 'teste')
    user = Collaborator.create!(email: 'other@test.com', password: 'password', 
                                company: company, admin: 1)

    login_as user, scope: :collaborator
    visit collaborators_path

    click_on 'Atualizar Empresa'

    fill_in 'Nome', with: ''
    click_on 'Atualizar Company'

    expect(page).to have_content 'Name não pode ficar em branco'
  end

  scenario 'successfully, social networks field' do
    company = Company.create!(name: 'teste')
    user = Collaborator.create!(email: 'other@test.com', password: 'password', 
                                company: company, admin: 1)

    login_as user, scope: :collaborator
    visit collaborators_path

    click_on 'Atualizar Empresa'
    click_on 'Adicionar redes sociais'

    fill_in 'Nome', with: 'Instagram'
    fill_in 'URL', with: 'http://teste.com'
    click_on 'Criar Social network'

    expect(page).to have_content 'Voltar'
    expect(page).to have_content 'Instagram'
    expect(page).to have_content 'http://teste.com'
  end

  scenario 'field blank, social networks field' do
    company = Company.create!(name: 'teste')
    user = Collaborator.create!(email: 'other@test.com', password: 'password', 
                                company: company, admin: 1)

    login_as user, scope: :collaborator
    visit collaborators_path

    click_on 'Atualizar Empresa'
    click_on 'Adicionar redes sociais'

    fill_in 'Nome', with: ''
    fill_in 'URL', with: ''
    click_on 'Criar Social network'

    expect(page).to have_content 'Name não pode ficar em branco'
    expect(page).to have_content 'Url não pode ficar em branco'
  end
end
