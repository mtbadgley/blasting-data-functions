Feature: NPIRemediation
	In order ensure that no unsecure data is migrated
	As a V1 Administrator
	I want all strings matching secure data patterns to be masked

@maskacreditcard
Scenario: Mask a Credit Card Number
	Given I have supplied a string of "This is a valid CC 4111 2231 2312 2322"
	And I scan using this pattern "\b((67\d{2})|(4\d{3})|(5[1-5]\d{2})|(6011))-?\s?\d{4}-?\s?\d{4}-?\s?\d{4}\b"
	When I find a match
	Then the result should be a string of "This is a valid CC XXXX XXXX XXXX XXXX"

@maskmultiplecreditcards
Scenario: Mask Multiple Credit Card Numbers
	Given I have supplied a string of "This is a valid CC 4111 2231 2312 2322 and so is 4111 2323 1232 4444"
	And I scan using this pattern "\b((67\d{2})|(4\d{3})|(5[1-5]\d{2})|(6011))-?\s?\d{4}-?\s?\d{4}-?\s?\d{4}\b"
	When I find a match
	Then the result should be a string of "This is a valid CC XXXX XXXX XXXX XXXX and so is XXXX XXXX XXXX XXXX"

@dontmaskacreditcard
Scenario: Do not Mask a Credit Card Number
	Given I have supplied a string of "This is an invalid CC 41 2231 2312 2322"
	And I scan using this pattern "\b((67\d{2})|(4\d{3})|(5[1-5]\d{2})|(6011))-?\s?\d{4}-?\s?\d{4}-?\s?\d{4}\b"
	When I don't find a match
	Then the result should be a string of "This is an invalid CC 41 2231 2312 2322"

@maskasocialsecuritynumber
Scenario: Mask a Social Security Number
	Given I have supplied a string of "This is a valid SSN 256-59-8889"
	And I scan using this pattern "\b([0-6]\d{2}|7[0-6]\d|77[0-2])(\s|\-)?(\d{2})\2(\d{4})\b"
	When I find a match
	Then the result should be a string of "This is a valid SSN XXX-XX-XXXX"

@dontmaskasocialsecuritynumber
Scenario: Do not Mask a Social Security Number
	Given I have supplied a string of "This is an invalid SSN 996-59-8889"
	And I scan using this pattern "\b([0-6]\d{2}|7[0-6]\d|77[0-2])(\s|\-)?(\d{2})\2(\d{4})\b"
	When I don't find a match
	Then the result should be a string of "This is an invalid SSN 996-59-8889"

@maskacustomernumber
Scenario: Mask a Customer Number
	Given I have supplied a string of "This is a valid eight digit C# 43453342"
	And I scan using this pattern "\b[0-9]{8}\b"
	When I find a match
	Then the result should be a string of "This is a valid eight digit C# XXXXXXXX"

@dontmaskacustomernumber
Scenario: Do not Mask a Customer Number
	Given I have supplied a string of "This is an invalid eight digit C# AA453342"
	And I scan using this pattern "\b[0-9]{8}\b"
	When I don't find a match
	Then the result should be a string of "This is an invalid eight digit C# AA453342"

@multipleitemsmatch
Scenario: Array of Patterns Match
	Given I have supplied a string of "This has 4111 2321 3323 5454 and 321 2322 23223 33 and 255-65-8739 and 12345678 and 123456789 and 777-88-9999"
	When I have an array of patterns to match
	Then the result should be "This has XXXX XXXX XXXX XXXX and 321 2322 23223 33 and XXX-XX-XXXX and XXXXXXXX and 123456789 and 777-88-9999" 