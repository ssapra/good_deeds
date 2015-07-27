Feature: Interacting with legislators data
  As a website visitor
  I want to search and view legislator data
  Because I want to learn about the legislators

  Background:
    Given the following legislators exist:
      | firstname   | lastname    | party | title | state   |
      | Bob         | Jones       | D     | Rep   | IL      |
      | Alice       | Smith       | R     | Sen   | NY      |

  @javascript
  Scenario: See all legislators
    Given I visit "/"
    When I search "legislators"
    Then I see 2 legislators

  @javascript
  Scenario: Search legislators by name
    Given I visit "/"
    When I search "Bob"
    Then I see 1 legislators

  @javascript
  Scenario: Search legislators by title
    Given I visit "/"
    When I search "Representative"
    Then I see 1 legislators

  @javascript
  Scenario: Search legislators by party
    Given I visit "/"
    When I search "Republican"
    Then I see 1 legislators

  @javascript
  Scenario: Search legislators by state
    Given I visit "/"
    When I search "Illinois"
    Then I see 1 legislators

  @javascript
  Scenario: View a particular legislator
    Given I visit "/"
    And I search "Bob"
    When I click on "Bob"
    Then I see the legislator page for "Bob"
