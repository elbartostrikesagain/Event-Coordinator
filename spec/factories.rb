require 'factory_girl'

###### User #######

FactoryGirl.define do
  factory :user do
    name
    email
    password 'please'
  end
end

FactoryGirl.define do
  sequence(:email) do |i|
    "user_#{i}@test.com"
  end
  sequence(:name) do |i|
    "Test User #{i}"
  end
end

##### MainEvent ######

FactoryGirl.define do
  factory :main_event do |e|
    e.name 'Main Event Name'
    e.user {(FactoryGirl.create :user)}
  end
end

####### Event ########

FactoryGirl.define do
  factory :event do |e|
    e.title 'Event Title'
    e.starts_at Time.now
    e.ends_at {Time.now + 5.hours}
    e.all_day false
    e.description 'Event description'
    e.num_users 1
    e.main_event {FactoryGirl.create :main_event}
  end
end

#### Authentication ####
FactoryGirl.define do
  factory :authentication do |a|
    a.user {FactoryGirl.create :user}
    a.provider "twitter"
    a.uid "115769842"
  end
end
