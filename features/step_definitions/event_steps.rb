Given /^I have created a main event$/ do
  @main_event = FactoryGirl.create(:main_event, user: @current_user)
end

Given /^A main event exists$/ do
  @main_event = FactoryGirl.create(:main_event)
end

Given /^A user is registered with the main event$/ do
  @user = FactoryGirl.create(:user)
  @main_event.workers << @user
  @main_event.save!
end