Feature: Signing in
  As a website visitor
  I want to sign in
  Because I want to customize my preferences

Scenario: Sign in
  Given I am logged out
  And I have an account
  When I sign in correctly
  Then I see the account page

Scenario: Incorrect email
  Given I am logged out
  And I have an account
  When I sign in with the wrong email
  Then I see an invalid email/password message

Scenario: Incorrect password
  Given I am logged out
  And I have an account
  When I sign in with the wrong password
  Then I see an invalid email/password message
