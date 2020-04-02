# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccountActivationMailer, type: :mailer do
  describe 'emails' do
    user = User.create!(first_name: 'User22', email: 'user22@gmail.com', password: 'password22')
    let(:mail) { described_class.inform(user).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('Activate Account')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['no-reply@brownfieldofdreams.io'])
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to match(user.first_name)
    end
  end
end
