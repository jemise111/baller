class UserMailer < ActionMailer::Base
  default from: "jesse.sessler@gmail.com"

  def game_email(user, game)
    @user = user
    @game = game
    # need a url?
    mail(to: @user.email, subject: 'New game activity!')
  end

  def welcome_email(user)
    @user = user
    # need a url?
    mail(to: @user.email, subject: 'Welcome to BallerNYC!')
  end
end
