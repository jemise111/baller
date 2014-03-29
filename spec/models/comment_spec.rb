require 'spec_helper'

describe Comment do
  let(:comment) { Comment.create(body: 'Court has sweet rims, no cracks, lots of players.') }
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
