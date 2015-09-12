Feature: GeekHub Homepage Login
Scenario: LogIn to GeekHub with Valid email and password
Given  I am on the LogIn page 
When enter email password and click LogIn
Then I should LogIn and see text  Signed in successfully