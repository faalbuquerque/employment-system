# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

company = Company.create!(name: 'My company')

collaborador = Collaborator.create!(email: 'collaborador@test.com', 
                                  password: '123456', company: company, admin: 1)

job = company.jobs.create!(title_job: 'Suporte', description: 'Atender telefone',
                           salary_range: '1500', level: 'senior', 
                           requisite: 'Linux', date_limit: '01-01-2050', 
                           quantity: '2', status: 'available')

candidateA = Candidate.create!(email: 'candidateA@test.com', name: 'TesterA', 
                               cpf: '33333333333', telephone: '11922222222', 
                               bio: 'Testando as coisas',password: '123456')

candidateB = Candidate.create!(email: 'candidateB@test.com', name: 'TesterB', 
                               cpf: '33333333333', telephone: '11922222222', 
                               bio: 'Testando as coisas',password: '123456')

candidateC = Candidate.create!(email: 'candidateC@test.com', name: 'TesterC', 
                               cpf: '33333333333', telephone: '11922222222', 
                               bio: 'Testando as coisas',password: '123456')

application = candidateC.applications.create!(job: job)

proposal = application.proposals.create!(message: 'Essa é nossa proposta',
                                         wage:4000, date_init:'01-01-2060')
