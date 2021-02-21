require 'rails_helper'

feature 'Candidate apply to job' do
  scenario 'successfully' do
    company = Company.create!(name: 'tester')
    admin = Collaborator.create!(email: 'test@tester.com', password: 'password',
                                 company: company)

    job = Job.create!(title_job: 'Desenvolvedor', 
                      description: 'Desenvolvedor rails', salary_range: '3000', level: 'Sênior', requisite: 'Experiencia com Git', date_limit: '2022-01-01', quantity: '3', company: company, status: 'Disponivel')

    candidate = Candidate.create!(email: 'candidate@test.com', name: 'Tester', 
                                  cpf: '33333333333', telephone: '11922222222', 
                                  bio: 'Testando as coisas',password: 'password')

    login_as candidate, scope: :candidate
    visit root_path

    fill_in 'Busca:', with: 'rails'
    click_on 'Pesquisar'

    click_on job.title_job
    click_on 'Candidatar'

    expect(page).to  have_content 'Candidatura efetuada!'
    expect(page).to  have_content job.title_job
  end

  scenario 'failure, already applied' do
    company = Company.create!(name: 'tester')
    admin = Collaborator.create!(email: 'test@tester.com', password: 'password', 
                                 company: company)

    job = Job.create!(title_job: 'Desenvolvedor', 
                      description: 'Desenvolvedor rails', salary_range: '3000', level: 'Sênior', requisite: 'Experiencia com Git', date_limit: '2022-01-01', quantity: '3', company: company, status: 'Disponivel')

    candidate = Candidate.create!(email: 'candidate@test.com', name: 'Tester', 
                                  cpf: '33333333333', telephone: '11922222222', 
                                  bio: 'Testando as coisas',password: 'password')

    login_as candidate, scope: :candidate
    visit root_path

    fill_in 'Busca:', with: 'rails'
    click_on 'Pesquisar'

    click_on job.title_job
    click_on 'Candidatar'

    fill_in 'Busca:', with: 'rails'
    click_on 'Pesquisar'

    click_on job.title_job
    click_on 'Candidatar'

    expect(page).to  have_content 'Oops, erro na candidatura!'
    expect(page).to  have_content 'Candidatar'
  end

  scenario 'failure, job not available' do
    company = Company.create!(name: 'tester')
    admin = Collaborator.create!(email: 'test@tester.com', password: 'password',
                                 company: company)

    job = Job.create!(title_job: 'Desenvolvedor', 
                      description: 'Desenvolvedor rails', salary_range: '3000', level: 'Sênior', requisite: 'Experiencia com Git', date_limit: '2040-01-01', quantity: '3', company: company, status: 'Disponivel')
    job.update_attribute(:date_limit, Date.new(1990,01,01))

    candidate = Candidate.create!(email: 'candidate@test.com', name: 'Tester',
                                  cpf: '33333333333', telephone: '11922222222',
                                  bio: 'Testando as coisas',password: 'password')

    login_as candidate, scope: :candidate
    visit root_path

    fill_in 'Busca:', with: 'rails'
    click_on 'Pesquisar'

    click_on job.title_job

    expect(page).to  have_content job.title_job
    expect(page).to_not  have_content 'Candidatar'
  end

  scenario 'failure, when reach maximum accepted applications' do
    company = Company.create!(name: 'test')

    collaborador = Collaborator.create!(email: 'collaborador@test.com', 
                                        password: 'password', company: company, 
                                        admin: 1)

    job = company.jobs.create!(title_job: 'Suporte', description: 'Atender telefone',
                               salary_range: '1500', level: 'Pleno', 
                               requisite: 'Linux', date_limit: '01-01-2050', 
                               quantity: '2', status: 'Disponivel')

    candidateA = Candidate.create!(email: 'candidateA@test.com', name: 'TesterA', 
                                   cpf: '33333333333', telephone: '11922222222', 
                                   bio: 'Testando as coisas',password: '123456')

    candidateB = Candidate.create!(email: 'candidateB@test.com', name: 'TesterB', 
                                   cpf: '33333333333', telephone: '11922222222', 
                                   bio: 'Testando as coisas',password: '123456')

    candidateC = Candidate.create!(email: 'candidateC@test.com', name: 'TesterC', 
                                   cpf: '33333333333', telephone: '11922222222', 
                                   bio: 'Testando as coisas',password: '123456')

    candidateA.jobs << job
    candidateB.jobs << job


    job.applications.first.update_attribute(:status, 'aceita')
    job.applications.last.update_attribute(:status, 'aceita')

    login_as candidateC, scope: :candidate

    visit job_path(job)

    expect(page).to have_content 'Indisponivel'
    expect(page).to_not have_content 'Candidatar'
  end
end
