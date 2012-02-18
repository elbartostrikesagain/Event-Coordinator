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

