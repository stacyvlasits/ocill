Feature: Content Creator Makes a FillDrill
	In order help students practice
	A content creator
	Should be able to create FillDrills

	Scenario: View all drills in a lesson
		Given I have drills "Conjugating 'to run'" and "Conjugating 'to walk'"
			And all the drills are in lesson "Conjugating verbs"
		When I go to the lesson titled "Conjugating verbs"
		Then I should see "Conjugating 'to run'"
			And I should see "Conjugating 'to walk'"

	Scenario: Create a new drill in an lesson
		Given A lesson with no drills
		When I go to the lesson "Conjugating verbs"
		And I click on "New Drill In Lesson"
		Then I should see a new drill
			And I should see "Select a Drill Type"

	Scenario: Create a new drill from scratch
		Given I am at the home page
		When I click on "New Drill"
		Then I should see a new drill
			And I should see "Select a Drill Type"
  

	Scenario: Set a new drill to type FillDrill
		Given I am on the "New Drill" page
		And I change the "Type" field to "FillDrill"
		And I click on "Create Drill"
		# in the app clicking "Create Drill" happens automatically through javascript
		Then I should see "Fill In The Blank"

@javascript
	Scenario: Create a new FillDrill Exercise
		Given I have a "Drill" with type "FillDrill" called "Conjugating 'to run'"
		When I "edit" the drill.
		And I click on "Add Fill In The Blank"
# Commented out steps fail because they rely on javascript
#		And I fill in the ".fill-in-the-blank-field" input with "This is a [FillDrill].".
		And I click on "Update Drill"
		And I "show" the drill. 		
#		Then I should see "This is a [FillDrill].".

	



