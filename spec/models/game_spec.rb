require 'spec_helper'

describe Game do
  it { should belong_to(:organizer) }
  it { should have_many(:attendances) }
  it { should have_many(:players).through(:attendances) }

  it { should validate_presence_of(:organizer_id) }
  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:end_time) }
  it { should validate_presence_of(:location_id) }
  it { should validate_presence_of(:min_attendance) }
  it { should validate_presence_of(:max_attendance) }
  it { should validate_presence_of(:status) }
end
