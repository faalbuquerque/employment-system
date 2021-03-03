require 'rails_helper'
RSpec.describe Job, type: :model do
  context 'validation' do
    it 'blank fields' do
      company = Company.create!(name: 'tester')
      collaborator = Collaborator.create!(email: 'testa@tester.com', 
                                          password: 'password', 
                                          company: company)

      job = Job.new(title_job: '', description: '', salary_range: '', 
                        level: 'senior', requisite: '', date_limit: '2022-01-01', 
                        quantity: '', company: company, status: 'available')

      expect(job.valid?).to_not eq(true)
      expect(job.errors[:title_job]).to include('não pode ficar em branco')
      expect(job.errors[:description]).to include('não pode ficar em branco')
      expect(job.errors[:salary_range]).to include('não pode ficar em branco')
      expect(job.errors[:requisite]).to include('não pode ficar em branco')
      expect(job.errors[:quantity]).to include('não pode ficar em branco')
    end

    it{ is_expected.to belong_to(:company) }
    it{ is_expected.to have_many(:applications) }
    it{ is_expected.to have_many(:candidates) }

    it{ is_expected.to validate_presence_of :title_job }
    it{ is_expected.to validate_presence_of :description }
    it{ is_expected.to validate_presence_of :salary_range }
    it{ is_expected.to validate_presence_of :level }
    it{ is_expected.to validate_presence_of :requisite }
    it{ is_expected.to validate_presence_of :quantity }

    it { should define_enum_for(:status) }
    it { should define_enum_for(:level) }
  end
end
