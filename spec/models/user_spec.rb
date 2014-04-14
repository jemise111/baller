require 'spec_helper'

describe User do

  it { should have_many(:comments) }
  it { should have_and_belong_to_many(:games) }
  it { should have_secure_password }
  it { should have_many(:comments) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_numericality_of(:zip_code).only_integer }
  it { should allow_value(nil).for(:zip_code) }

  # it do
  #   should ensure_length_of(:zip_code).
  #   is_equal_to(5).
  #   with_message(/zip_code must be 5 digits long/)
  # end

  # it do
  #   should ensure_length_of(:password).
  #   is_at_least(5).
  #   with_message('password must be at least 5 characters')
  # end

  it do
    User.create!(name: 'Jesse Sessler',
                 email: 'jesse@sessler.com',
                 password: '12345',
                 password_confirmation: '12345')
    should validate_uniqueness_of(:email)
  end

  subject(:mike) { User.create(name: 'Mike Jones',
                        email: 'mike.jones@gmail.com',
                        zip_code: 10001,
                        password: 'mikejones',
                        password_confirmation: 'mikejones') }
  it 'should be created with a name, email, zip code, password, created_at time' do
    expect(mike.name).to eq('Mike Jones')
    expect(mike.email).to eq('mike.jones@gmail.com')
    expect(mike.zip_code).to eq(10001)
    expect(mike.password_digest).to_not be_nil
    expect(mike.created_at).to be_within(1).of(Time.now)
  end
end
