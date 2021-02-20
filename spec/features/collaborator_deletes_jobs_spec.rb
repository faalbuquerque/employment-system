require 'rails_helper'

feature 'Collaborator deletes jobs spec' do

  scenario 'successfully' do
    company = Company.create!(name: 'tester')
    admin = Collaborator.create!(email: 'test@tester.com', password: 'password', 
                                 company: company)

    job_dev = Job.create!(title_job: 'Desenvolvedor', 
                          description: 'Desenvolvedor rails', salary_range: '3000', level: 'Sênior', requisite: 'Experiencia com Git', date_limit: '2022-01-01', quantity: '3', company: company, status: 'Disponivel')
    job_infra = Job.create!(title_job: 'Sys Adm', 
                            description: 'Gerenciar equipe', salary_range: '5000', level: 'Pleno', requisite: 'Experiencia como dba', date_limit: '2021-02-03', quantity: '2', company: company, status: 'Disponivel')

    login_as admin, scope: :collaborator

    visit root_path
    click_on admin.company.name

    find('a#delete_job_2').click

    expect(page).to_not have_content 'Sys Adm'
    expect(page).to have_content 'Desenvolvedor'
  end
end