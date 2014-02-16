# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video_version do
    resolution '320x200'
    processed 0
    progress false
    video
  end
end