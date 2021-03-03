require 'rails_helper'

RSpec.describe Proposal, type: :model do
  context 'validation' do
    it{ is_expected.to belong_to(:application) }

    it{ is_expected.to validate_presence_of :message }
    it{ is_expected.to validate_presence_of :wage }
    it{ is_expected.to validate_presence_of :date_init }
    it{ is_expected.to validate_presence_of :status }
  end
end
