Feature: Student Does a Fill Drill
  In order learn about language
  A student
  Should be answer questions from a Fill Drill

  Scenario: View all drills that are assigned to me
  # Given I am logged in.
    Given I have a drill called "Conjugating 'to run'".
    Given I have a drill called "Conjugating 'to walk'".
 #  And The drills have been assigned to me.
    When I am on the "Drills" page.
    Then I should see "Conjugating 'to walk'"
      And I should see "Conjugating 'to run'"

  Scenario: Do a Fill Drill
   # Given I am logged in.
    Given I have a drill called "Conjugating 'to run'".
    And The drill has an exercise called "Tomorrow, I am [going to run]. (to run)".
 #  And The drills have been assigned to me.
    And I am on the drill's page.
    When I click on "Do Drill" next to "Conjugating 'to run'".
    Then I should see "Tomorrow, I am"
    And I should see ". (to run)".
    But I should not see "going to run"

  Scenario: Complete an exercise
    Given I have a drill called "Conjugating 'to run'".
    And The drill has an exercise called "Tomorrow, I am [going to run]. (to run)".
    And I am on the page "Conjugating 'to run'"
    When I type the answer "going to run".
    And I click "Submit Drill".
    Then I should see "Your Drill has been Submitted".
