require 'spec_helper'

describe Attendance do
  it { should belong_to(:game) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:game_id) }
end
