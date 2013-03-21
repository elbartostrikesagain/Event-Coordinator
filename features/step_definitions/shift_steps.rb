Given /^I have created an event|An event exists$/ do
  @event = FactoryGirl.create(:event, main_event: @main_event)
end

Then /^I should not see the event$/ do
  step %{I should not see "#{@event.title}"}
end

Then /^I should be registered with the event$/ do
  @event.reload.users.include?(@current_user).should be_true
end

Then /^I should not be registered with the event$/ do
  @event.reload.users.include?(@current_user).should be_false
end

When /^I search for the user$/ do
  fill_in "name", :with => @user.name
  step %{I follow "Search"}
end

Then /^the user should be registered for the shift$/ do
  @event.reload.users.include?(@user).should be_true
end

Then /^the user should should not be registered for the shift$/ do
  @event.reload.users.include?(@user).should be_false
end
