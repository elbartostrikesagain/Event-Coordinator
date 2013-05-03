Given /^I have created a main event$/ do
  @main_event = FactoryGirl.create(:main_event, user: @current_user)
end

Given /^a main event exists$/ do
  @main_event = FactoryGirl.create(:main_event)
end

Given /^A user is registered with the main event$/ do
  @user = FactoryGirl.create(:user)
  @main_event.workers << @user
  @main_event.save!
end

Then /^I should be editing the main event$/ do
  page.should have_content "Editing #{@main_event.name}"
end

Then /^the events name should be "(.*?)"$/ do |name|
  @main_event.reload.name.should == name
end