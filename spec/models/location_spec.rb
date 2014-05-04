require 'spec_helper'

describe Location do
  it { should belong_to(:mayor) }
  it { should have_many(:games) }
  
  it { should validate_presence_of(:mayor_id) }
  it { should validate_presence_of(:name) }
end
