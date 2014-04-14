require 'spec_helper'

describe Comment do

  it { should belong_to(:user) }
  it { should belong_to(:court) }
  it { should validate_presence_of(:body) }

  # it do
  #    should ensure_length_of(:body).
  #     is_at_least(1).
  #     is_at_most(200).
  #     with_short_message(/contain text/).
  #     with_long_message(/too long/)
  # end

  subject(:comment) { Comment.create(body: 'Court has sweet rims, no cracks, lots of players.') }
  before(:each) do
    comment.update(approved: false)
  end
  describe '.new' do
    it 'should be created with a body, created_at time, and not be approved' do
      expect(comment.body).to eq('Court has sweet rims, no cracks, lots of players.')
      expect(comment.created_at).to be_within(1).of(Time.now)
      expect(comment.approved).to eq(false)
    end
  end
end
