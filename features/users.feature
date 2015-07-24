Feature: Managing account settings
  As a website visitor
  I want to sign in and manage my profile
  Because I want to see relevant data

  Scenario: Add valid zipcode
    Given I am a new user
    And I visit the account page
    When I set "user_zipcode" as "60606"
    Then I see "Updated zipcode"

  Scenario: Add invalid zipcode
    Given I am a new user
    And I visit the account page
    When I set "user_zipcode" as "99999"
    Then I see "Zipcode must be a valid US zipcode"

  Scenario: Update with new zipcode
    Given I am a user with zipcode "12345"
    And I visit the account page
    When I set "user_zipcode" as "60606"
    Then I see "Updated zipcode"

  Scenario: Update with new valid email
    Given I am a new user
    And I visit the account page
    When I set "user_email" as "mynewemail@gmail.com"
    Then I see "Updated email"

  Scenario: Update with new invalid email
    Given I am a new user
    And I visit the account page
    When I set "user_email" to be "notvalidemail"
    Then I see "Email must be valid"

  Scenario: Update political party
    Given I am a new user with political party "Democratic Party"
    And I visit the account page
    When I select political party "Republican Party"
    Then I see "Updated political party"

  Scenario: Add interest tag
    Given I am a new user
    And I visit the account page
    When I add a new tag "Food"
    Then I see a confirmation message

  Scenario: Remove interest tag
    Given I am a new user
    And I visit the account page
    When I add a new tag "Food"
    When I remove tag "Food"
    Then I see a confirmation message

  Scenario: Add duplicate tag
    Given I am a new user with tags "Food, Weather"
    And I visit the account page
    When I add a new tag "Food"
    Then I see an error message

  Scenario: Add multiple tag
    Given I am a new user with tags "Food, Weather"
    And I visit the account page
    When I add a new tag "Animals"
    And I add a new tag "Taxes"
    Then I have 4 tags
