require 'rails_helper'

feature 'Collaborator or candidate cancels application' do
  scenario 'successfully, collaborator cancels' do
    company = Company.create!(name: 'tester')

    collaborator = Collaborator.create!(email: 'test@tester.com', 
                                        password: 'password', company: company)

    job = Job.create!(title_job: 'Desenvolvedor', 
                      description: 'Desenvolvedor rails', salary_range: '3000', level: 'Sênior', requisite: 'Experiencia com Git', date_limit: '2022-01-01', quantity: '3', company: company, status: 'available')

    job_dba = Job.create!(title_job: 'DBA', 
                        description: 'Gerenciar database', salary_range: '5000', level: 'Sênior', requisite: 'Experiencia com Linux', date_limit: '2022-01-01', quantity: '3', company: company, status: 'available')

    candidate = Candidate.create!(email: 'candidate@test.com', name: 'Tester', 
                                  cpf: '33333333333', telephone: '11922222222', 
                                  bio: 'Testando as coisas',password: 'password')

    login_as candidate, scope: :candidate
    visit root_path

    fill_in 'Buscar Vagas', with: 'rails'
    click_on 'Pesquisar'

    click_on job.title_job
    click_on 'Candidatar'

    login_as collaborator, scope: :collaborator
    visit root_path

    click_on 'Dashboard'
    click_on 'Candidaturas'

    find("#job_#{job.id}").click

    click_on 'Cancelar candidatura'

    fill_in 'Mensagem:', with: 'Processo finalizado'

    click_on 'Enviar mensagem'

    expect(page).to  have_content 'Candidatura cancelada!'
    expect(page).to  have_content 'Situacao de sua candidatura: Cancelada'
    expect(page).to_not have_content 'Cancelar candidatura'
  end

  scenario 'successfully, candidate cancels' do
    company = Company.create!(name: 'tester')

    collaborator = Collaborator.create!(email: 'test@tester.com', 
                                        password: 'password', company: company)

    job = Job.create!(title_job: 'Desenvolvedor', 
                      description: 'Desenvolvedor rails', salary_range: '3000', level: 'Sênior', requisite: 'Experiencia com Git', date_limit: '2022-01-01', quantity: '3', company: company, status: 'available')

    job_dba = Job.create!(title_job: 'DBA', 
                        description: 'Gerenciar database', salary_range: '5000', level: 'Sênior', requisite: 'Experiencia com Linux', date_limit: '2022-01-01', quantity: '3', company: company, status: 'available')

    candidate = Candidate.create!(email: 'candidate@test.com', name: 'Tester', 
                                  cpf: '33333333333', telephone: '11922222222', 
                                  bio: 'Testando as coisas',password: 'password')

    login_as candidate, scope: :candidate
    visit root_path

    fill_in 'Buscar Vagas', with: 'rails'
    click_on 'Pesquisar'

    click_on job.title_job
    click_on 'Candidatar'

    click_on 'Dashboard'
    click_on 'Candidaturas'

    find("#application_#{candidate.applications.first.id}").click

    click_on 'Cancelar candidatura'

    fill_in 'Mensagem:', with: 'Nao quero mais'

    click_on 'Enviar mensagem'

    expect(page).to  have_content 'Candidatura cancelada!'
    expect(page).to  have_content 'Situacao de sua candidatura: Cancelada'
    expect(page).to_not have_content 'Cancelar candidatura'
  end
end
