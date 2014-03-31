class User < ActiveRecord::Base
  has_many(:comments)
  has_and_belongs_to_many(:games)
  has_secure_password
  validates(:name, presence: true)
  validates(:email, uniqueness: true,
                    presence: true)
  validates(:password, presence: true,
                       length: { minimum: 5,
                                 message: 'must be at least 5 characters'})
  validates(:zip_code, numericality: { only_integer: true },
                       length: { is: 5, message: 'must be 5 digits long' },
                       allow_blank: true)
end
