require 'rubygems'
require 'watir-webdriver'
require "watir-webdriver/extensions/alerts"
require 'colorize'
require 'mysql2'

browser = Watir::Browser.new
client = Mysql2::Client.new(host: 'localhost', database: 'messageboard_development', username: 'root', password: 'password')

#Scenario1

Given(/^I am on the LogIn page$/) do
  browser.goto "http://localhost:3000/users/sign_in"
end

When(/^enter email password and click LogIn$/) do
  browser.text_field(:type,"email").set("test@example.com")
  browser.text_field(:type,"password").set("password")
  browser.button(:name,"commit").click
end

Then(/^I should LogIn and see text  Signed in successfully$/) do
   if browser.text.include? "Signed in successfully." 
   	puts "successfully logged in".green
   else
   	puts "error unable to login".red
   end
end

#Scenario2
Given(/^user is already Logged in$/) do

 if browser.link(:href,"/users/sign_out").exists?
 	puts "users is already logged in".green
 else
 	puts "Error user not logged in ".red
 end 	
end

When(/^user clicks SignOut$/) do
  browser.link(:href,"/users/sign_out").click
end

Then(/^user shoud be signed out$/) do
if browser.link(:href,"/users/sign_in").exists?
 	puts "User is signed out".green
 else
 	puts "Error user not signed out".red
 end 
end

Then(/^see text Signed out successfully$/) do
   if browser.text.include? "Signed out successfully." 
   	puts "successfully signed out".green
   else
   	puts "error unable to signedout".red
   end
end

#Scenario3
Given(/^User is logged in$/) do
  browser.goto "http://localhost:3000/users/sign_in"
  browser.text_field(:type,"email").set("test@example.com")
  browser.text_field(:type,"password").set("password")
  browser.button(:name,"commit").click

end

Given(/^New message link is visible$/) do
 if browser.link(:href,"/messages/new").exists?
    puts"New Message link is visible".green
 else
    puts "error New message is not visible".red
 end
end

When(/^New Message link is clicked$/) do
   browser.link(:href,"/messages/new").click
end

When(/^Message Title and description are entered and create Message button is clicked$/) do
  browser.text_field(:name,"message[title]").set ("Cucumber")
  browser.textarea(:name,"message[description]").set("testing framework")
  browser.button(:value,"Create Message").click
  @sql = "select id from messages where title='Cucumber'"
  @messageid = client.query(@sql)
  @messageid.each do |row|
	$message_id = row['id']
  end 
end

Then(/^New Message is visible on Homepage$/) do
  if browser.text.include? "Cucumber"
  	puts "New Message is visible on home page".green
  else
  	puts " error New message title not visible".red
  end
end

#Scenario4
Given(/^user logged in$/) do
  if browser.link(:href,"/users/sign_out").exists?
 	puts "users is already logged in".green
 else
 	 puts "Error user not logged in ".red
 end 
end

Given(/^Create Comment is visible in Message details$/) do
    if browser.link(:href,"/messages/#{$message_id}").exists?
    	puts " view details is visible".green
    	browser.link(:href,"/messages/#{$message_id}").click
    else
    	puts " error view details is not visible".red
     end
  if browser.button(:value,"Create Comment").exists?
  	puts "create comment button is visible".green
  else
  	puts "error create comment button not visible".red
  end
end

When(/^comment is entered in comment section$/) do
 browser.textarea(:id,"comment_content").set("test comment")
end

When(/^Create Comment button is clicked$/) do
  browser.button(:value,"Create Comment").click
end

Then(/^comment is posted$/) do
  if browser.text.include? "test comment"
  	puts "comment is posted succusfully ".green
  else
  	puts " error comment posted is not visible".red
  end
  @sql_comment = "select id from comments where content='test comment'"
  @commentid = client.query(@sql_comment)
  @commentid.each do |row|
	$comment_id = row['id']
  end 
end

#Scenario5

Given(/^User logged in$/) do
  browser.goto "http://localhost:3000"
end

When(/^Message details is clicked$/) do
 browser.link(:href,"/messages/#{$message_id}").click
end

Then(/^comment edit and delete links are visible$/) do
  if browser.link(:href,"/messages/#{$message_id}/comments/#{$comment_id}/edit").exists?
  	puts "edit link is visible ".green
  else
  	puts "error edit link is not visible".red
  end
  if browser.link(:href,"/messages/#{$message_id}/comments/#{$comment_id}").exists?
  	puts "delete link is visible ".green
  else
  	puts " error delete link is not visible".red
  end
end


#Scenario-6

Given(/^Message ID is known$/) do
	  browser.goto "http://localhost:3000"
	puts "Message id is #{$message_id}".green
end

Given(/^Comment ID is known$/) do
  puts "Comment id is #{$comment_id}".green
end

When(/^Message details page is loaded$/) do
 browser.link(:href,"/messages/#{$message_id}").click
end

Then(/^Delete Comment$/) do
browser.link(:href,"/messages/#{$message_id}/comments/#{$comment_id}").click
browser.alert.ok
end

Then(/^Delete Message$/) do
browser.link(:href,"/messages/#{$message_id}").click
browser.alert.ok
  browser.link(:href,"/users/sign_out").click
  browser.close
end
