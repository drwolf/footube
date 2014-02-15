# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video do
    title 'My nice video'
    description 'A video of a cat sitting on a robot vacuum cleaner'
    processed false
  end
end
