Feature: Managing account settings
  As a website visitor
  I want to sign in and manage my profile
  Because I want to see relevant data

  Scenario: Add valid zipcode
    Given I am a new user
    And I visit the account page
    When I set my zip code
    Then I see a confirmation message

  Scenario: Add invalid zipcode
    Given I am a new user
    And I visit the account page
    When I set an invalid zip code
    Then I see an error message

  Scenario: Update with new valid zipcode
    Given I am a user with a zipcode
    And I visit the account page
    When I change my zipcode
    Then I see a confirmation message

  Scenario: Update with new invalid zipcode
    Given I am a user with a zipcode
    And I visit the account page
    When I change my zipcode to be invalid
    Then I see an error message

  Scenario: Update with new valid email
    Given I am a user
    And I visit the account page
    When I change my email
    Then I see a confirmation message

  Scenario: Update with new invalid email
    Given I am a user
    And I visit the account page
    When I change my email to be invalid
    Then I see an error message

  Scenario: Add political party
    Given I am a new user
    And I visit the account page
    When I select a political party
    Then I see a confirmation message

  Scenario: Change political party
    Given I am a new user with political party "Democratic Party"
    And I visit the account page
    When I select political party "Republican Party"
    Then I see a confirmation message

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
