Given /^I have created a main event$/ do
  @main_event = Factory.create(:main_event, user: @current_user)
end