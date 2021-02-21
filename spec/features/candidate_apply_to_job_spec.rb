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
end
