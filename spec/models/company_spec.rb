require 'rails_helper'

RSpec.describe Company, type: :model do
  context 'validation' do

    it{ is_expected.to have_many(:social_networks) }
    it{ is_expected.to have_many(:collaborators) }
    it{ is_expected.to have_many(:jobs) }

    it{ is_expected.to validate_presence_of :name }
  end
end
