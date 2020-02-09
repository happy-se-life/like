class LikeMailer < Mailer
    def on_like(user_to, title, content)
        @title = title
        @content = content
        mail to: user_to.mail, subject: @title
    end
end