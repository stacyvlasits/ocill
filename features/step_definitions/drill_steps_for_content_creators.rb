Given(/^I have drills "(.*?)" and "(.*?)"$/) do |drill1_title, drill2_title|
    @unit = FactoryGirl.create(:unit)
    @drill1 = FactoryGirl.create(:fill_drill, title: drill1_title, unit_id: @unit.id)
    @drill2 = FactoryGirl.create(:fill_drill, title: drill2_title, unit_id: @unit.id)
  end

Given(/^all the drills are in unit "(.*?)"$/) do |unit_title|
  @unit.title = unit_title
end

When(/^I go to the unit titled "(.*?)"$/) do |unit_title|
  visit('/units/' + @unit.id.to_s )
end

Then(/^I should see "(.*?)"$/) do |arg1|
  # binding.pry if arg1 == "Conjugating 'to walk'"
  page.should have_content(arg1)
end

Given(/^A unit with no drills$/) do
  @unit = FactoryGirl.create(:unit)
end

When(/^I go to the unit "(.*?)"$/) do |unit_title|
  @unit = FactoryGirl.create(:unit, title: unit_title)
  visit('/units/' + @unit.id.to_s )
end

Then(/^I should see a new drill$/) do
  page.should have_content("New Drill")
end

Given(/^I am at the home page$/) do
  visit('/')
end

When(/^I click on "(.*?)"$/) do |link_or_button_text|
  click_on link_or_button_text
end

Given(/^I am on the "(.*?)" page$/) do |title|
  title_parts = title.split(" ")
  action = title_parts[0].downcase
  controller = title_parts[1].downcase.pluralize
  visit("/#{controller}/#{action}/")
end

Given(/^I change the "(.*?)" field to "(.*?)"$/) do |select_box, option|
  select(option, from: select_box)
end

Given(/^I have a "(.*?)" with type "(.*?)" called "(.*?)"$/) do |model, type, title|
  @model = model.downcase!
  model.to_sym
  @instance = FactoryGirl.create(model, type: type,title: title)
end

When(/^I "(.*?)" the drill\.$/) do |verb|
  visit("/#{@model.pluralize}/#{@instance.id}/#{verb}")
end

Then(/^I should see an input for a fill in the blank.$/) do
  page.should have_selector('.fill-in-the-blank-field')
end

When(/^I fill in the (.*?) input with "(.*?)"\.$/) do |selector, text|
  fill_in('.fill-in-the-blank-field', :with => text)
end

Then(/^I should see "(.*?)"\.$/) do |content|
  page.should have_content(content)
end