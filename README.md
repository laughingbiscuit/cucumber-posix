# Cucumber POSIX

## Description

I like BDD, especially the gherkin syntax. 
I would like to use it for shell testing.
I don't want to install ruby/node/java and use those to run shell commands.
Lets just create a gherkin -> shell preprocessor using `sed`!

Here is a little prototype

## Example

We have a feature file:

```
Feature: As a developer I want do something so that something happens

  Scenario: Happy path
    Given I set a variable
    When I list files
    Then I receive success

  Scenario: Failure path
    When I do something random
    Then I receive failure

```

We can use `./step_definitions.sh` (less than 25 lines!) to convert to shell.

```
cat Test.feature | ./step_definitions.sh 
```

... for the following result...

```
$ cat Test.feature | ./step_definitions.sh 

#!/bin/sh
set -e
# Feature: As a developer I want do something so that something happens

# Scenario: Happy path

## Given I set a variable
export A=B

## When I list files
ls

## Then I receive success
[ 0 -eq 0 ]

# Scenario: Failure path

## When I do something random
ls

## Then I receive failure
[ 0 -ne 0 ]
echo "Tests complete."
```

We can then pipe this into sh to return the test, with a zero exit code indicating success.

## Improvements

I can imagine running each scenario inside a docker container for free teardown. I can also imagine some useful reporting and a larger set of gherkin syntax support.
