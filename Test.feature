Feature: As a developer I want do something so that something happens

  Scenario: Happy path
    Given I set a variable
    When I list files
    Then I receive success

  Scenario: Failure path
    When I do something random
    Then I receive failure

