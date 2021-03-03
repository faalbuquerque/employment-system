require 'rails_helper'

RSpec.describe Application, type: :model do
  context 'validation' do

    it{ is_expected.to have_many(:proposals) }
    it{ is_expected.to belong_to(:candidate) }
    it{ is_expected.to belong_to(:job) }

    it { should define_enum_for(:status) }

  end
end
