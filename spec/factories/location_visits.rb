# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location_visit do
    user_id 1
    location_id 1
    visit_time "2014-05-04 11:05:59"
  end
end
