require 'rails_helper'

RSpec.describe Collaborator, type: :model do
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
end
