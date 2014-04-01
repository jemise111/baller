class User < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  has_many(:comments, dependent: :delete_all)
  # set up dependency?
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
