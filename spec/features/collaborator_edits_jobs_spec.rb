require 'rails_helper'

feature 'Collaborator edits jobs' do
  scenario 'successfully' do
    company = Company.create!(name: 'tester')
    admin = Collaborator.create!(email: 'test@tester.com', password: 'password', 
                                 company: company)

     job = Job.create!(title_job: 'Desenvolvedor', 
                       description: 'Desenvolvedor rails', salary_range: '3000', level: 'senior', requisite: 'Experiencia com Git', date_limit: '2022-01-01', quantity: '3', company: company, status: 'available')

    login_as admin, scope: :collaborator

    visit root_path
    click_on admin.company.name
    click_on 'Editar job'

    fill_in 'Nome', with: 'Nome da Vaga'
    fill_in 'Descrição', with: 'Detalhes da vaga'
    fill_in 'Salario', with: '10000'
    select 'Junior', from: 'Nivel'
    fill_in 'Requisitos', with: 'Requisitos necessarios para a vaga'
    fill_in 'Data limite', with: '01-01-2022'
    fill_in 'Quantidade de vagas', with: '4'
    select 'Unavailable', from: 'Status'

    click_on 'Atualizar Job'

    expect(page).to  have_content 'Nome da Vaga'
    expect(page).to  have_content 'Detalhes da vaga'
    expect(page).to  have_content '10.000,00'
    expect(page).to  have_content 'junior'
    expect(page).to  have_content 'Requisitos necessarios para a vaga'
    expect(page).to  have_content '01/01/2022'
    expect(page).to  have_content '4'
    expect(page).to  have_content 'Status: unavailable'
  end

  scenario 'failure, cant enable job with date in the past' do
    company = Company.create!(name: 'tester')
    admin = Collaborator.create!(email: 'test@tester.com', password: 'password', 
                                 company: company)

    job = Job.create!(title_job: 'Desenvolvedor', 
                       description: 'Desenvolvedor rails', salary_range: '3000', level: 'senior', requisite: 'Experiencia com Git', date_limit: '2022-01-01', quantity: '3', company: company, status: 'available')
    job.update_attribute(:date_limit, Date.new(1900,01,02))

    login_as admin, scope: :collaborator
    visit edit_job_path(Job.last)
    click_on 'Atualizar Job'

    expect(page).to  have_content 'Date limit não pode ser no passado!'
    expect(page).to_not  have_content 'Vaga alterada com sucesso!'
  end
end
