require 'rails_helper'

RSpec.describe NotificationsMailer, type: :mailer do
  describe 'new_appliance' do
    let(:mail) { NotificationsMailer.new_appliance }

    it 'renders the headers' do
      expect(mail.subject).to eq('New appliance')
      expect(mail.to).to eq(['to@example.org'])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi')
    end
  end

end
