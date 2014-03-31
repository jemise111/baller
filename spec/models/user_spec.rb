require 'spec_helper'

describe User do
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
