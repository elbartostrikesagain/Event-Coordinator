Then /^show me the page$/ do
  save_and_open_page
end

When /^debugger$/ do
  binding.pry
end