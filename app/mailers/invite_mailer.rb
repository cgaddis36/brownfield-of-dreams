class InviteMailer < ApplicationMailer

  def invite(invited_user, inviter)
    @inviter = inviter
    @invited_handle = invited_user[:login]
    @invited_email = invited_user[:email]

    mail(to: @invited_email, subject: "You're invited to join Turing Tutorials")
  end
end
