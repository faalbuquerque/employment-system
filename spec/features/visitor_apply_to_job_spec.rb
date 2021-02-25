require 'rails_helper'

feature 'Visitor apply to job' do
  scenario 'successfully' do
    company = Company.create!(name: 'tester')
    admin = Collaborator.create!(email: 'test@tester.com', password: 'password', 
                                 company: company)

    job = Job.create!(title_job: 'Desenvolvedor', 
                      description: 'Desenvolvedor rails', salary_range: '3000', level: 'senior', requisite: 'Experiencia com Git', date_limit: '2022-01-01', quantity: '3', company: company, status: 'available')

    visit root_path

    fill_in 'Buscar Vagas', with: 'rails'
    click_on 'Pesquisar'

    click_on job.title_job
    click_on 'Candidatar'
    click_on 'Sign up'

    fill_in 'Email', with: 'test@test.com'
    fill_in 'Name',	with: 'Tester' 
    fill_in 'Cpf', with: '33333333333'
    fill_in 'Telephone', with: '11 9 56565666'
    fill_in 'Bio', with: 'Estudante de testes'

    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'

    click_on 'Candidatar'

    expect(page).to  have_content 'Candidatura efetuada!'
    expect(page).to  have_content job.title_job
  end
end
