require 'rails_helper'

RSpec.describe SocialNetwork, type: :model do
  context 'validation' do
    it{ is_expected.to belong_to(:company) }

    it{ is_expected.to validate_presence_of :name }
    it{ is_expected.to validate_presence_of :url }
  end
end
