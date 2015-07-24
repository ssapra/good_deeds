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
    When I set "user_email" as "notvalidemail"
    Then I see "Email is invalid"

  Scenario: Update political party
    Given I am a new user with political party "Democratic Party"
    And I visit the account page
    When I select political party "Republican Party"
    Then I see "Updated political party"

  Scenario: Add interest tag
    Given I am a new user
    And there exists tags "Hunting"
    And I visit the account page
    When I select "Hunting"
    Then I see "Updated tags"

  @javascript
  Scenario: Remove interest tag
    Given I am a new user with tags "Agriculture, Transportation"
    And I visit the account page
    And I remove "Agriculture"
    Then I see "Updated tags"
    And I have 1 tags

  Scenario: Add duplicate tag
    Given I am a new user with tags "Agriculture, Transportation"
    And I visit the account page
    When I select "Agriculture"
    Then I see "Duplicate tag"

  Scenario: Add multiple tags
    Given I am a new user with tags "Food, Weather"
    And there exists tags "Education, Rental"
    And I visit the account page
    When I select "Education"
    And I select "Rental"
    Then I have 4 tags
