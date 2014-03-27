require 'spec_helper'

describe User do
  let(:mike) { User.new(name: 'Mike Jones',
                        email: 'mike.jones@gmail.com',
                        zip_code: 10001,
                        password: 'mikejones',
                        password_confirmation: 'mikejones') }
  it 'should be created with a name, email, zip code, password' do
    expect(mike.name).to eq('Mike Jones')
    expect(mike.email).to eq('mike.jones@gmail.com')
    expect(mike.zip_code).to eq(10001)
    expect(mike.password_digest).to_not be_nil
  end
end
