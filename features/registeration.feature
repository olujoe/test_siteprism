@registration @done
Feature: Register on the site
	As a user, I want to be able to register on the website so I can save my progress


Background: delete all saved budget data before starting
	Given I have deleted all cookies

@done	
Scenario: registration page false validation
	Given I am on the registration page
	Then I should get the following errors when I register with these details:
	|field					|value						|error							|
	|email					|							|Can't be blank					|
	|email					|1							|Invalid address				|
	|email					|123244@					|Invalid address				|
	|email					|test_mas@mailinator.com	|								|
	|password				|							|Can't be blank					|
	|password				|1							|Doesn't match confirmation		|
	|repeat_password		|							|								|
	|repeat_password		|1							|								|
	|first_name				|							|Can't be blank					|
	|first_name				|1							|Invalid						|
	|first_name				|a							|								|
	|surname				|							|Can't be blank					|
	|surname				|1							|Invalid						|
	|surname				|w							|								|
	|terms_and_conditions	|							|Must be accepted				|
	|terms_and_conditions	|set						|								|
	|postcode				|r							|Invalid post code				|
	|postcode				|SE1						|								|
	|postcode				|EC1N 2TD					|								|
	
@done
Scenario: registration page password validation
	Given I am on the registration page
	Then I should get the following errors with these form data:
	|password		|repeat password	|error								|
	|qqqq			|qqqq				|Too short (minimum 8 characters)	|
	|qqqqqqqq		|wwwwwwww			|Doesn't match confirmation			|
	
@done	
Scenario: register	
	Given I am on the registration page
	When I register with these details:
	|field					|value						|
	|email					|random email				|
	|password				|default password 			|
	|first_name				|test						|
	|surname				|user						|
	|terms_and_conditions	|set						|
	|postcode				|EC1N 2TD					|
	|day					|12							|
	|month					|March						|
	|year					|1970						|
	|gender					|Male						|
	|credit					|set						|
	Then I should see the thank you for registering page
	When I go to my details page
	Then I should see correct details stored
	
@done		
Scenario: duplicate registration	
	Given I am on the registration page
	When I register with these details:
	|field					|value						|
	|email					|random email				|
	|password				|default password 			|
	|first_name				|test						|
	|surname				|user						|
	|terms_and_conditions	|set						|
	|postcode				|EC1N 2TD					|
	|day					|12							|
	|month					|March						|
	|year					|1970						|
	|gender					|Male						|
	|credit					|set						|
	Then I should see the thank you for registering page
	When I click on the 'Sign out' button
	And I am on the registration page
	And I enter the previous email address into the email field and submit the form
	Then I should see the error "has already been taken" in the email error field
