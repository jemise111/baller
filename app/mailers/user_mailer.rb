class UserMailer < ActionMailer::Base
  default from: "jesse.sessler@gmail.com"

  def game_email(user, game)
    @user = user
    @game = game
    # need a url?
    mail(to: @user.email, subject: 'New game activity!')
  end
end
