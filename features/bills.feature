Feature: Search and viewing bills
  As a website visitor
  I want to find bills
  Because I want to learn about Congress

  Background:
    Given these bills exist:
      | official_title                                    | short_title                                 | summary_short                                                                 |
      | To amend the Federal Food, Drug, and Cosmetic Act | Safe and Accurate Food Labeling Act of 2015 | a plant or part of a plant that has been modified through recombinant DNA...  |

  @javascript
  Scenario: Search using a part of the official_title
    Given I am a new user
    When I search "Federal Food"
    Then I see 1 bills

  @javascript
  Scenario: Search using a part of the short_title
    Given I am a new user
    When I search "Food Labeling"
    Then I see 1 bills

  @javascript
  Scenario: Search using a part of the summary
    Given I am a new user
    When I search "DNA recombinant"
    Then I see 1 bills

  @javascript
  Scenario: Click on search result
    Given I am a new user
    When I search "DNA recombinant"
    And I click on "recombinant DNA"
    Then I see the bill page for "Safe and Accurate Food Labeling Act of 2015"

  @javascript
  Scenario: No results found for search
    Given I am a new user
    When I search "mystery alient act of 2025"
    Then I see no results found
