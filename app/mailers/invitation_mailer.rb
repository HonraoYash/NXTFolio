# frozen_string_literal: true

class InvitationMailer < ApplicationMailer
  def invitation_email(email, details)
    @invited_name = details[:invited_name]
    @inviter_name = details[:inviter_name]
    @invited_email = details[:email]
    @project_name = details[:project_name]
    @project_url = galleries_show_url(id: details[:project_key])
    mail(to: email, subject: 'You have been invited to collaborate on a project.')
  end
end