Feature: Operations as a logged in user
  As a user of the Expense Tracker application
  I want to be able to make CRUD operations on exposed resources
  In order to be sure that business logic of the application works as it should
  
  Background:
    Given a mojo test object for the "ExpenseTracker" application      
    When I log in with username "tudor" and password "123"
    Then I should see the "welcome tudor" text
    
  Scenario: Create currencies
    Given the following currencies
      |name|
      |EUR|
      |USD|
      |RON|
      |CAD|
    When I create them through the REST API
    Then I should be able to see their names

