Given /^I have created a main event$/ do
  @main_event = FactoryGirl.create(:main_event, user: @current_user)
end

Given /^I have created an event$/ do
  @event = FactoryGirl.create(:event, main_event: @main_event)
end

Then /^I should not see the event$/ do
  step %{I should not see "#{@event.title}"}
end