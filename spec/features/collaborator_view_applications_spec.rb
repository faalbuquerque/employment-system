require 'rails_helper'

feature 'Collaborator view applications' do
  scenario 'successfully' do
    company = Company.create!(name: 'tester')
    collaborator = Collaborator.create!(email: 'test@tester.com', 
                                        password: 'password', company: company)

    job = Job.create!(title_job: 'Desenvolvedor', 
                      description: 'Desenvolvedor rails', salary_range: '3000', level: 'Sênior', requisite: 'Experiencia com Git', date_limit: '2022-01-01', quantity: '3', company: company, status: 'Disponivel')

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
    click_on 'Informações de candidaturas'

    expect(page).to  have_content 'Candidaturas recebidas: 1'
    expect(page).to  have_content candidate.name
    expect(page).to  have_content candidate.email
  end
end
