# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attendance do
    user_id 1
    game_id 1
    status "MyString"
  end
end
