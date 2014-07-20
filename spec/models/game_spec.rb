require 'spec_helper'

describe Game do
  it { should belong_to(:organizer) }
  it { should belong_to(:activity) }
  it { should belong_to(:location) }
  it { should have_many(:attendances) }
  it { should have_many(:players).through(:attendances) }

  it { should validate_presence_of(:organizer_id) }
  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:end_time) }
  it { should validate_presence_of(:location_id) }
  it { should validate_presence_of(:size) }
  it { should validate_presence_of(:status) }
end
