Given(/^I have a drill called "(.*?)"\.$/) do |title|
  @drill = Drill.new(title: title)
end

When(/^I am on the "(.*?)" page\.$/) do |model|
  model = model.downcase.pluralize
  visit('/' + model)
end

When(/^I am on the drill's page\.$/) do
    visit('/drills/' )
end

Given(/^The drill has an exercise called "(.*?)"\.$/) do |title|
  @exercise = @drill.exercises.new(title: title)
end

When(/^I click on "(.*?)" next to "(.*?)"\.$/) do |link, content|
  
end

Then(/^I should not see "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given(/^I am on the page "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I type the answer "(.*?)"\.$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I click "(.*?)"\.$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end