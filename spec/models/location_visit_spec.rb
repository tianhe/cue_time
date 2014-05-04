require 'spec_helper'

describe LocationVisit do
  it { should belong_to(:location) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:location_id) }
  it { should validate_presence_of(:visit_time) }
end
