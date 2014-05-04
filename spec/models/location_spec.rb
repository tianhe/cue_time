require 'spec_helper'

describe Location do
  it { should belong_to(:user) }

  it { should validate_presence_of(:mayor_id) }
  it { should validate_presence_of(:name) }
end
