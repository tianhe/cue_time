# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    min_attendance 1
    max_attendance 1
    organizer_id 1
    start_time "2014-05-04 11:11:21"
    end_time "2014-05-04 11:11:21"
    location_id ""
    experience_level 1
    max_age 1
    min_age 1
    gender_requirement "MyString"
    drinks_requirement "MyString"
    competitiveness "MyString"
    status "MyString"
  end
end
