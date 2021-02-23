require 'rails_helper'

feature 'Collaborator search companies' do
  scenario 'successfully' do
    company1 = Company.create!(name: 'Company1')
    admin1 = Collaborator.create!(email: 'test@company1.com', password: 'password', 
                                 company: company1)

    company2 = Company.create!(name: 'Company2')
    admin2 = Collaborator.create!(email: 'test@company2.com', password: 'password', 
                                 company: company2)

    job_sup = company2.jobs.create!(title_job: 'Suporte', description: 'Atender telefone',
                                    salary_range: '1500', level: 'Pleno', requisite: 'Linux',
                                    date_limit: '01-01-2050', quantity: '3', 
                                    status: 'Disponivel')

    job_dev = company1.jobs.create!(title_job: 'Desenvolvedor', 
                                    description: 'Manutencao de sistemas',
                                    salary_range: '3000', level: 'Júnior', requisite: 'Rails',
                                    date_limit: '10-10-2100', quantity: '2', 
                                    status: 'Disponivel')

    login_as admin2, scope: :collaborator

    visit root_path
    fill_in 'Buscar Vagas', with: 'Sup'
    click_on 'Pesquisar'

    expect(current_path).to eq search_path
    expect(page).to have_content('Suporte')
    expect(page).to have_content('Pleno')
    expect(page).to have_content('01/01/2050')
  end
end
