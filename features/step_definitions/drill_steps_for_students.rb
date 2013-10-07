Given(/^I have a drill called "(.*?)"\.$/) do |title|
  @drill = Drill.create(title: title)
end

Given(/^I have a "(.*?)" drill called "(.*?)"\.$/) do |drill_type, title|
  drill_type = drill_type.to_s + "Drill"
  @drill = Drill.create(title: title, type: drill_type)
end

When(/^I am on the "(.*?)" page\.$/) do |model|
  model = model.downcase.pluralize
  visit('/' + model)
end

When(/^I am on the drills page\.$/) do
    binding.pry
    visit('/drills/' )

end

Given(/^The drill has an exercise called "(.*?)"\.$/) do |title|
  @exercise = @drill.exercises.create(title: title)
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