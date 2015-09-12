Feature: GeekHub Homepage Login and SignOut

Scenario: LogIn to GeekHub with Valid email and password
Given  I am on the LogIn page 
When enter email password and click LogIn
Then I should LogIn and see text  Signed in successfully

Scenario: SignOut to GeekHub 
Given  user is already Logged in  
When user clicks SignOut 
Then user shoud be signed out 
And see text Signed out successfully