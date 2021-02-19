require 'rails_helper'

feature 'Collaborator registers jobs' do
  scenario 'successfully' do
    company = Company.create!(name: 'tester')
    admin = Collaborator.create!(email: 'test@tester.com', password: 'password', 
                                 company: company)

    login_as admin, scope: :collaborator

    visit root_path

    click_on admin.company.name

    click_on 'Cadastrar Job'

    fill_in 'Nome', with: 'Nome da Vaga'
    fill_in 'Descrição', with: 'Detalhes da vaga'
    fill_in 'Salario', with: '10000'
    select 'Sênior', from: 'Nivel'
    fill_in 'Requisitos', with: 'Requisitos necessarios para a vaga'
    fill_in 'Data limite', with: '01-01-2022'
    fill_in 'Quantidade de vagas', with: '3'
    select 'Disponivel', from: 'Status'

    click_on 'Criar Job'

    expect(page).to  have_content 'Nome da Vaga'
    expect(page).to  have_content 'Detalhes da vaga'
    expect(page).to  have_content '10.000,00'
    expect(page).to  have_content 'Sênior'
    expect(page).to  have_content 'Requisitos necessarios para a vaga'
    expect(page).to  have_content '01/01/2022'
    expect(page).to  have_content '3'
  end

  scenario 'blank fields' do
    company = Company.create!(name: 'test')
    admin = Collaborator.create!(email: 'test@test.com', password: 'password', 
                                 company: company)

    login_as admin, scope: :collaborator
    visit root_path

    click_on admin.company.name

    click_on 'Cadastrar Job'

    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Salario', with: ''
    fill_in 'Requisitos', with: ''
    fill_in 'Quantidade de vagas', with: ''

    click_on 'Criar Job'

    expect(page).to  have_content 'Title job não pode ficar em branco'
    expect(page).to  have_content 'Description não pode ficar em branco'
    expect(page).to  have_content 'Salary range não pode ficar em branco'
    expect(page).to  have_content 'Requisite não pode ficar em branco'
    expect(page).to  have_content 'Quantity não pode ficar em branco'
  end

  scenario 'deadline test in data' do
    last_date = 30.days.from_now
    day = last_date.day
    month = last_date.strftime("%m")
    year = last_date.year

    company = Company.create!(name: 'test')
    admin = Collaborator.create!(email: 'test@test.com', password: 'password', 
                                 company: company)

    login_as admin, scope: :collaborator
    visit root_path

    click_on admin.company.name
    click_on 'Cadastrar Job'

    fill_in 'Nome', with: 'Nome da Vaga'
    fill_in 'Descrição', with: 'Detalhes da vaga'
    fill_in 'Salario', with: '100'
    select 'Pleno', from: 'Nivel'
    fill_in 'Requisitos', with: 'Requisitos necessarios para a vaga'
    fill_in 'Data limite', with: ''
    fill_in 'Quantidade de vagas', with: '33'
    select 'Disponivel', from: 'Status'

    click_on 'Criar Job'

    expect(page).to  have_content 'Nome da Vaga'
    expect(page).to  have_content 'Detalhes da vaga'
    expect(page).to  have_content '100,00'
    expect(page).to  have_content 'Pleno'
    expect(page).to  have_content 'Requisitos necessarios para a vaga'
    expect(page).to  have_content  "#{day}/#{month}/#{year}"
    expect(page).to  have_content '33'
    expect(page).to  have_content 'Disponivel'
  end
end
