require 'rails_helper'

feature 'Admin collaborator delete company' do

  scenario 'successfully' do
    company = Company.create!(name: 'test')
    admin = Collaborator.create!(email: 'tester@test.com', password: 'password', 
                                 company: company, admin: 1)

    login_as admin, scope: :collaborator
    visit root_path

    click_on 'Atualizar Empresa'
    click_on 'Apagar Empresa'

    expect(page).to have_content 'Dados de test apagados com sucesso!'
  end

  scenario 'failure, already destroyed' do
    company = Company.create!(name: 'test')
    admin = Collaborator.create!(email: 'tester@test.com', password: 'password',
                                 company: company, admin: 1)

    login_as admin, scope: :collaborator
    visit root_path
    click_on 'Atualizar Empresa'

    company.destroy

    click_on 'Apagar Empresa'

    expect(page).to_not have_content 'Dados de test apagados com sucesso!'
    expect(page).to  have_content 'Para continuar, efetue login ou registre-se'
  end

  scenario 'failure, another company\'s admin' do
    company1 = Company.create!(name: 'company1')
    company2 = Company.create!(name: 'company2')

    admin1 = Collaborator.create!(email: 'test@company1.com', password: 'password', 
                                 company: company1, admin: 1)
    admin2 = Collaborator.create!(email: 'test@company2.com', password: 'password', 
                                 company: company2, admin: 1)

    login_as admin1, scope: :collaborator

    visit root_path
    click_on 'Atualizar Empresa'

    login_as admin2, scope: :collaborator

    click_on 'Apagar Empresa'

    expect(page).to_not have_content 'Dados de company1 apagados com sucesso!'
    expect(page).to have_content 'Boas vindas test@company2.com'
    expect(Company.all.count).to eq 2
  end
end
