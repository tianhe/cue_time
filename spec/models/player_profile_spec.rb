require 'spec_helper'

describe PlayerProfile do
  it { should belong_to(:user) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:ranking) }
  it { should validate_presence_of(:wins) }
  it { should validate_presence_of(:losses) }
end
