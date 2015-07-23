Feature: Signing up
  As a website visitor
  I want to sign in
  Because I want to customize my preferences

Scenario: Sign up
  Given I am logged out
  And I visit the sign up page
  When I sign up correctly
  Then I see the email verification message

Scenario: Email verification
  Given I sign up correctly
  When I verify the email
  Then I see the account page

Scenario: Email already taken
  Given I am logged out
  And I visit the sign up page
  When I sign up with a used email
  Then I see an email already taken message

Scenario: Invalid email
  Given I am logged out
  And I visit the sign up page
  When I sign up with an invalid email
  Then I see an invalid email error message

Scenario: Inadequate password
  Given I am logged out
  And I visit the sign up page
  When I sign up with an inadequate password
  Then I see an bad password error message
