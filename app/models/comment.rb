class Comment < ActiveRecord::Base
  belongs_to(:user)
  belongs_to(:court)
  validates(:body, presence: true,
            length: {minimum: 1, message: 'Comment must contain text'},
            length: {maximum: 200, message: 'Comment is too long'})
end

