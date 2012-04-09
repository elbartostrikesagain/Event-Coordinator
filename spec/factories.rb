require 'factory_girl'

###### User #######

Factory.define :user do |u|
  u.name {Factory.next(:name)}
  u.email {Factory.next(:email)}
  u.password 'please'
end

Factory.sequence(:email) do |i|
  "user_#{i}@test.com"
end

Factory.sequence(:name) do |i|
  "Test User #{i}"
end

##### MainEvent ######

Factory.define :main_event do |e|
  e.name 'Main Event Name'
  e.user {(Factory.create :user)}
end

####### Event ########

Factory.define :event do |e|
  e.title 'Event Title'
  e.starts_at Time.now
  e.ends_at {Time.now + 5.hours}
  e.all_day false
  e.description 'Event description'
  e.num_users 1
  e.main_event {Factory.create :main_event}
end

#### Authentication ####
Factory.define :authentication do |a|
  a.user {Factory.create :user}
  a.provider "twitter"
  a.uid "115769842"
end
