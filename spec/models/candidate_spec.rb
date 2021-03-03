require 'rails_helper'

RSpec.describe Candidate, type: :model do
  context 'validation' do
    it 'not valid when email is blank' do
      candidate = Candidate.new(email:'', password:'')

      expect(candidate.valid?).to_not eq(true)
      expect(candidate.errors[:email]).to include('não pode ficar em branco')
      expect(candidate.errors[:password]).to include('não pode ficar em branco')
    end

    it{ is_expected.to have_many(:applications) }
    it{ is_expected.to have_many(:jobs) }

    it{ is_expected.to validate_presence_of :name }
    it{ is_expected.to validate_presence_of :cpf }
    it{ is_expected.to validate_presence_of :telephone }
    it{ is_expected.to validate_presence_of :bio }
  end
end
