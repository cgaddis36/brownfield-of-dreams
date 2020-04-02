# frozen_string_literal: true

class AccountActivationMailer < ApplicationMailer
  def inform(user)
    @user = user
    @token = SecureRandom.hex(10).to_s

    mail(to: user.email, subject: 'Activate Account')
  end
end
