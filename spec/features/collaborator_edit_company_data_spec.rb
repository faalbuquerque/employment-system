require 'rails_helper'

feature 'Collaborator edit company data' do
  xscenario 'successfully' do
    company = Company.create!(name: 'teste')
    admin = Collaborator.create!(email: 'other@test.com', password: 'password', company: company, admin: 1)

    login_as admin, scope: :collaborator
    visit root_path
    
    click_on 'Preencher informações da Empresa'

    fill_in 'name', with: 'Empresa Teste'
    fill_in 'logo', with: 'imagem@link.com'
    fill_in 'address', with: 'Rua lalala, 11'
    fill_in 'cnpj', with: '32197584871'
    fill_in 'site', with: 'teste.com.br'
    click_on 'Salvar'

    expect(page).to have_content('Voltar')
    expect(page).to have_content('Edite sua empresa')
    expect(page).to have_content('Empresa Test')
    expect(page).to have_content('imagem@link.com')
    expect(page).to have_content('Rua lalala, 11')
    expect(page).to have_content('32197584871')
    expect(page).to have_content('teste.com.br')
  end

  xscenario 'name field blank' do
    company = Company.create!(name: 'teste')
    user = Collaborator.create!(email: 'other@test.com', password: 'password', company: company)

    login_as user, scope: :collaborator
    visit root_path
    click_on 'Cadastrar Empresa'

    fill_in 'name', with: ''
    click_on 'Cadastrar'

    expect(page).to have_content('name não pode ficar em branco')
  end

  xscenario 'social networks field' do
    company = Company.create!(name: 'teste')
    user = Collaborator.create!(email: 'other@test.com', password: 'password', company: company)

    login_as user, scope: :collaborator
    visit root_path
    click_on 'Preencher informações da Empresa'

    click_on 'Adicionar rede sociail'

    fill_in 'name', with: 'Instagram'
    fill_in 'url', with: 'http://teste.com'

    click_on 'Salvar'

    expect(page).to have_current_path(edit_company_path(company))
    expect(page).to have_content('Instagram')
    expect(page).to have_content('http://teste.com')
  end
end
