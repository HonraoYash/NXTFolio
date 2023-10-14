Feature: add a comment in a project
  As a valid collaborator with a project
  I want to add a comment in the project


  Background: galleries in database

  Given the following users exist
    | name              | password  | job | city | state | id | highlights |
    | Andrea.Picardo   | Test1234! | Model | Houston | TX | 2 | test | 

  Given the following galleries for testing delete exist
  | title | description | total  | id|  num|
  | t1    | high1       | 20     |  2  | 4 |

Scenario: User can view the add comment button in their gallery
  Given I am logged in as "Andrea.Picardo"
  Given I am a valid gallery user
  Given I am on the home page
  When I click on "t1"
  Then I should see "Enter a comment"

Scenario: Users can successfully submit a comment on a portfolio posting
  Given I am logged in as "Andrea.Picardo"
  Given I am a valid gallery user
  Given I am on the home page
  When I click on "t1"
  Then I should see "Enter a comment"
  And I click the "Enter a comment"
  Then I should be able to see the comment page
  When I fill in the comment box with details
  And I click on "Submit Comment" button
  And the new comment "Great work on this portfolio!" should be displayed
  
  Scenario: Users cannot submit a blank comment on a portfolio posting
  Given I am logged in as "Andrea.Picardo"
  Given I am a valid gallery user
  Given I am on the home page
  When I click on "t1"
  Then I should see "Enter a comment"
  And I click the "Enter a comment"
  Then I should be able to see the comment page
  When I leave the comment box empty
  And I click on "Submit Comment" button
  And no new comment should be posted


