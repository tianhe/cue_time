# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player_profile do
    experience "MyString"
    ranking 1
    wins 1
    losses 1
  end
end
