Feature: Operations as a logged in user
  As a user of the Expense Tracker application
  I want to be able to make CRUD operations on exposed resources
  In order to be sure that business logic of the application works as it should
  
  Background:
    Given a mojo test object for the "ExpenseTracker" application
      And the following users
      |username|password|email           |first_name|last_name |birth_date|
      |tudor   |123     |tudor@test.com  |tudor     |constantin|1982-26-08|
      |test1   |123     |test1@test.com  |tudor     |constantin|1982-26-08|
      |test2   |123     |test2@test.com  |tudor     |constantin|1982-26-08|
    When I create them through the REST API
     And I log in with username "tudor" and password "1234"
    Then I should see the "Username and password" text    
    When I log in with username "tudor" and password "123"
    Then I should see the "welcome tudor" text
     And I should be able to list their usernames
     And I should be able to get their ids

  Scenario: Create currencies
    Given the following currencies
      |name|
      |EUR|
      |USD|
      |RON|
      |CAD|
    When I create them through the REST API
    Then I should be able to list their names
     And I should be able to get their ids
     And I should be able to delete them
  
  Scenario: Manage categories
    Given the following categories
      |name        |description                      |parent_id|
      |Food        |Main category for food           |0        |
      |Fast food   |Fast food subcategory for food   |1        |
      |Shawormas   |Shawormas om nom nom             |2        |
      |Healthy food|Healthy food subcategory for food|1        |
      |Clothes     |Main category for clothes        |0        |
      |Pants       |Put your pants here              |5        |
      |Shoes       |Gimme the shoes                  |5        |
    When I create them through the REST API  
    Then I should be able to list their names
     And I should be able to get their ids
     
  Scenario: Delete categories
    Given the following categories     
      |name   |
      |Food   |
    Then I should be able to list their names
     And I should be able to get their ids
     And I should be able to delete the above by name
    
  Scenario: Child categories do not exist anymore
    Given the following categories
      |name        |
      |Fast food   |
      |Shawormas   |
      |Healthy food|
    Then I should not be able to find them by name
