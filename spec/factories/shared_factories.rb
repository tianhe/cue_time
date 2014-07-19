#User
FactoryGirl.define do
  factory :user, aliases: [:mayor, :organizer] do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    gender :male
    birthdate "10/04/1983"
    drinking_habit :light
    password "password"
    password_confirmation { |u| u.password }
  end

  factory :activity do
    name { Faker::Name.name }    
  end

  factory :user_activity do
    user
    activity
  end

  factory :player_profile do
    user

    experience "Rookie"
    ranking 1000
    wins 0
    losses 0
  end
end

#Location
FactoryGirl.define do
  factory :location do
    mayor

    name { Faker::Company.name }
    address { Faker::Address.street_address }
    city { 'New York' }
    state { 'GA'}
    zipcode { '10022' }
  end
end

FactoryGirl.define do
  factory :location_visit do
    user
    location

    visit_time "2014-05-04 11:05:59"
  end
end

#Game 
FactoryGirl.define do
  factory :game do
    organizer
    location
    
    title { Faker::Name.name }
    min_attendance 1
    max_attendance 10
    start_time "2014-05-04 11:11:21"
    end_time "2014-05-04 11:11:21"
    experience_level 1
    max_age 30
    min_age 18
    gender_requirement "male"
    drinks_requirement "social"
    competitiveness 1
    status "open"
  end
end

FactoryGirl.define do
  factory :attendance do
    user
    game

    status "pending"
  end
end
