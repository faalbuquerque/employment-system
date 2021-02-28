require 'rails_helper'

feature 'Candidate responds proposal' do
  scenario 'successfully, accepted' do
    company = Company.create!(name: 'tester')

    collaborator = Collaborator.create!(email: 'test@tester.com', password: 'password',
                                        company: company)

    job = Job.create!(title_job: 'Desenvolvedor', 
                      description: 'Desenvolvedor rails', salary_range: '3000', level: 'senior',requisite: 'Experiencia com Git', date_limit: '2050-01-01', quantity: '3',company: company, status: 'available')

    candidate = Candidate.create!(email: 'candidate@test.com', name: 'Tester',
                                  cpf: '33333333333', telephone: '11922222222',
                                  bio: 'Testando as coisas',password: 'password')

    application = candidate.applications.create!(job: job)

    proposal = application.proposals.create!(message:'Enviando proposta', wage:4000, date_init:'01-01-2060')

    login_as candidate, scope: :candidate

    visit applications_path
    click_on job.title_job
 
    click_on 'Responder proposta'

    fill_in 'Mensagem',	with: 'Gostei da proposta'
    fill_in 'Data de inicio',	with: '2050-01-01'
    select 'Accepted', from: 'Resposta'

    click_on 'Atualizar Proposal'

    expect(page).to  have_content 'Resposta enviada!'
    expect(page).to  have_content 'Status: accepted'
    expect(page).to  have_content 'Gostei da proposta'
    expect(page).to  have_content '01/01/2050'
  end

  scenario 'successfully, rejected' do
    company = Company.create!(name: 'tester')

    collaborator = Collaborator.create!(email: 'test@tester.com', password: 'password',
                                        company: company)

    job = Job.create!(title_job: 'Desenvolvedor', 
                      description: 'Desenvolvedor rails', salary_range: '3000', level: 'senior',requisite: 'Experiencia com Git', date_limit: '2050-01-01', quantity: '3',company: company, status: 'available')

    candidate = Candidate.create!(email: 'candidate@test.com', name: 'Tester',
                                  cpf: '33333333333', telephone: '11922222222',
                                  bio: 'Testando as coisas',password: 'password')

    application = candidate.applications.create!(job: job)

    proposal = application.proposals.create!(message:'Enviando proposta', wage:4000, date_init:'01-01-2060')

    login_as candidate, scope: :candidate

    visit applications_path
    click_on job.title_job
 
    click_on 'Responder proposta'

    fill_in 'Mensagem',	with: 'Nao tenho interesse'
    fill_in 'Data de inicio',	with: '2050-01-01'
    select 'Rejected', from: 'Resposta'

    click_on 'Atualizar Proposal'

    expect(page).to  have_content 'Resposta enviada!'
    expect(page).to  have_content 'Status: rejected'
    expect(page).to  have_content 'Nao tenho interesse'
    expect(page).to  have_content '01/01/2050'
  end

  scenario 'failure, field blanks' do
    company = Company.create!(name: 'tester')

    collaborator = Collaborator.create!(email: 'test@tester.com', password: 'password',
                                        company: company)

    job = Job.create!(title_job: 'Desenvolvedor', 
                      description: 'Desenvolvedor rails', salary_range: '3000', level: 'senior',requisite: 'Experiencia com Git', date_limit: '2050-01-01', quantity: '3',company: company, status: 'available')

    candidate = Candidate.create!(email: 'candidate@test.com', name: 'Tester',
                                  cpf: '33333333333', telephone: '11922222222',
                                  bio: 'Testando as coisas',password: 'password')

    application = candidate.applications.create!(job: job)

    proposal = application.proposals.create!(message:'Enviando proposta', wage:4000, date_init:'01-01-2060')

    login_as candidate, scope: :candidate

    visit applications_path
    click_on job.title_job
 
    click_on 'Responder proposta'

    fill_in 'Mensagem',	with: ''
    fill_in 'Data de inicio',	with: ''
    select 'Escolha', from: 'Resposta'

    click_on 'Atualizar Proposal'

    expect(page).to  have_content 'Message não pode ficar em branco'
    expect(page).to  have_content 'Date init não pode ficar em branco'
    expect(page).to  have_content 'Status não pode ficar em branco'
  end
end
