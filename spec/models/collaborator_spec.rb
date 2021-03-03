require 'rails_helper'

RSpec.describe Collaborator, type: :model do
  context 'validation' do
    it 'valid when have email' do
      company = Company.create!(name:'teste')
      collaborator = Collaborator.new(email:'teste@email.com',
                                      password:'123456',
                                      company: company)

      expect(collaborator.valid?).to eq(true)
    end

    it 'not valid when email is blank' do
      company = Company.create!(name:'teste')
      collaborator = Collaborator.new(email:'',
                                      password:'123456',
                                      company: company)

      expect(collaborator.valid?).to_not eq(true)
    end

    it 'is already registered' do
      company = Company.create!(name: 'teste')

      collaborator = Collaborator.create!(email: 'test@test.com', password: 'password',
      company: company)

      collaborator = Collaborator.new(email: 'test@test.com', password: 'password',
      company: company)

      expect(collaborator.valid?).to_not eq(true)
      expect(collaborator.errors[:email]).to include('já está em uso')
    end

    describe "associations" do
      it{ is_expected.to belong_to(:company) }
    end
  end
end
