Feature: Validate Geek Hub Features


Scenario: LogIn to GeekHub with Valid email and password
Given  I am on the LogIn page 
When enter email password and click LogIn
Then I should LogIn and see text  Signed in successfully

Scenario: SignOut to GeekHub 
Given  user is already Logged in  
When user clicks SignOut 
Then user shoud be signed out 
And see text Signed out successfully

Scenario:  Create New Message
Given User is logged in 
And New message link is visible
When New Message link is clicked 
And Message Title and description are entered and create Message button is clicked 
Then New Message is visible on Homepage

Scenario: Create Comment 
Given user logged in
And Create Comment is visible in Message details
When comment is entered in comment section 
And Create Comment button is clicked
Then comment is posted 

Scenario: Comment Edit and Delete links  
Given User logged in
When Message details is clicked
Then comment edit and delete links are visible

Scenario: Delete Comment and Message
Given Message ID is known
And Comment ID is known
When Message details page is loaded
Then Delete Comment
And Delete Message
