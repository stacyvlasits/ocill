Given(/^I am logged in as a "(.*?)"$/) do |role|
  include Warden::Test::Helpers
  Warden.test_mode!
  
  logged_in_user = User.new({
          :email => role.to_s + '@example.com',
          :password => 'password',
          :password_confirmation => 'password',
          :role => role.to_s })
  logged_in_user.save
  login_as logged_in_user
end