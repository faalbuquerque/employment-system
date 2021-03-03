require 'rails_helper'

feature 'Collaborator sends proposal' do
  scenario 'successfully' do
    company = Company.create!(name: 'tester')
    collaborator = Collaborator.create!(email: 'test@tester.com', password: 'password',
                                        company: company)
    job = Job.create!(title_job: 'Desenvolvedor', 
                      description: 'Desenvolvedor rails', salary_range: '3000', level: 'senior',requisite: 'Experiencia com Git', date_limit: '2050-01-01', quantity: '3',company: company, status: 'available')
    candidate = Candidate.create!(email: 'candidate@test.com', name: 'Tester',
                                  cpf: '33333333333', telephone: '11922222222',
                                  bio: 'Testando as coisas',password: 'password')
    application = candidate.applications.create!(job: job)

    login_as collaborator, scope: :collaborator

    visit job_path(job)
    click_on 'Enviar proposta'
    fill_in 'Mensagem',	with: 'Enviando proprosta'
    fill_in 'Salario',	with: '2000'

    click_on 'Criar Proposal'

    expect(page).to  have_content 'Status: pendent'
    expect(page).to  have_content 'Enviando proprosta'
    expect(page).to  have_content '2.000,00'
    expect(page).to  have_content '01/01/2050'
  end

  scenario 'failure, field blank' do
    company = Company.create!(name: 'tester')
    collaborator = Collaborator.create!(email: 'test@tester.com', password: 'password',
                                        company: company)
    job = Job.create!(title_job: 'Desenvolvedor', 
                      description: 'Desenvolvedor rails', salary_range: '3000', level: 'senior',requisite: 'Experiencia com Git', date_limit: '2050-01-01', quantity: '3',company: company, status: 'available')
    candidate = Candidate.create!(email: 'candidate@test.com', name: 'Tester',
                                  cpf: '33333333333', telephone: '11922222222',
                                  bio: 'Testando as coisas',password: 'password')
    application = candidate.applications.create!(job: job)

    login_as collaborator, scope: :collaborator

    visit job_path(job)
    click_on 'Enviar proposta'
    fill_in 'Mensagem',	with: ''
    fill_in 'Salario',	with: ''
    click_on 'Criar Proposal'

    expect(page).to  have_content 'Message não pode ficar em branco'
    expect(page).to  have_content 'Wage não pode ficar em branco'
    expect(page).to_not  have_content 'Proposta enviada!'
  end

  scenario 'failure, already sent' do
    company = Company.create!(name: 'tester')
    collaborator = Collaborator.create!(email: 'test@tester.com', password: 'password',
                                        company: company)
    job = Job.create!(title_job: 'Desenvolvedor', 
                      description: 'Desenvolvedor rails', salary_range: '3000', level: 'senior',requisite: 'Experiencia com Git', date_limit: '2050-01-01', quantity: '3',company: company, status: 'available')
    candidate = Candidate.create!(email: 'candidate@test.com', name: 'Tester',
                                  cpf: '33333333333', telephone: '11922222222',
                                  bio: 'Testando as coisas',password: 'password')
    application = candidate.applications.create!(job: job)
    proposal = application.proposals.create!(message:'Enviando proposta',
                                             wage:4000, date_init:'01-01-2060')

    login_as collaborator, scope: :collaborator

    visit job_path(job)

    expect(page).to_not  have_content 'Enviar proposta'
  end
end
