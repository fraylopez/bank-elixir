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
      - enitites
      - SomeCaseController.ex
