# frozen_string_literal: true

class RatingMailer < ApplicationMailer
  def gallery_rating_email(email, details)
    @owner_name = details[:owner_name]
    @reviewer_name = details[:reviewer_name]
    @project_name = details[:project_name]
    @rating = details[:rating]
    mail(to: email, subject: 'One of your projects has been rated')
  end
end
