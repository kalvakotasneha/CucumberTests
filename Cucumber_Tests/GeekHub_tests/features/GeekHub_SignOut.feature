Feature: GeekHub Homepage SignOut
Scenario: SignOut to GeekHub 
Given  user is already Logged in  
When user clicks SignOut 
Then user shoud be signed out 
And see text Signed out successfully