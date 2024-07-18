# Bank

## Architecture

![Architecture](./docs/out/architecture.png)

## Goals

- Architecture guidelines
  - What's architecture?
    - A set of rules that guide the development of a software system
    - Can I extend the functionality of the system?
      - Without changing the existing code (OCP)?
    - MVC == EBC
  - Why do we need it?
    - To make sure that the system is maintainable, scalable, and testable
- Code quality
- Test piramid?
  - unit
  - integration
  - e2e
  - mocks

## Decisions

- lib/
  - some_package_web/
  - some_package_messagebus/
  - some_package/
    - some_module/
      - enitites (models)
      - SomeCaseController.ex

## Fun list

- Users are the owners of accounts
- Removing users should close all accounts
- Use case to create a new user with a new account
- Users have a credit score [0-100%]
- Initial credit score is 100
- Users with balance > 0 can request a loan for up to 100% of their balance
- Loans reduce the credit score by the percentage of the loan amount relative to the user's balance
  (ie: 500 loan on a 1000 balance reduces the credit score by 50%)
- A user with a loan cannot close their last account
