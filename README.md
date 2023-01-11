# Little Esty Shop

## Background and Description

"Little Esty Shop" is a group project that requires students to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.

### Platform Organization

"Little Esty Shop" is composed of 6 major features, divided to be viewed as a Merchant or an Admin.
---
The features are:
Admin/
  - Dashboard
  - Merchants (Index & Show)
  - Invoices (Index & Show)

Merchant/
  - Dashboard
  - Items (Index & Show)
  - Invoices (Index & Show)

---

-- Merchant Dashboard
  - The Merchant Dashboard feature serves as a landing page for a specific Merchant instance. There are links to the other Merchant features (Items Index & Invoices Index).
  - The Merchant Dashboard contains statistics related to this Merchant's relationships, using Active Record.

-- Merchant Items
  - The Merchant Items feature perform Active Record and CRUD behaviors on Item instances only related to the particular Merchant.
  - Specific CRUD features include Enabling / Disabling (status change), Create an Item, Update an Item (show page)
  - Specific Active Record features include finding the top item (sales), and the top day for when the item was sold.

-- Merchant Invoices
  - The Merchant Invoices feature perform some CRUD behaviors on Invoices only related to the particular Merchant.
  - Updating the Invoice status (on the `merchants/:id/invoices/show` page) is done through a model form.

-- Admin Dashboard
  - The Admin Dashboard is similar to the Merchant Dashboard, in that is has links to navigate to the other Admin features. It also displays similar Active Record analysis, but it is applied to the entire db's records. (As opposed to objects belonging to a single Merchant.)

-- Admin Merchants
  - The Admin Merchants feature perform Active Record and CRUD behaviors on any of the database's Merchants =.
  - Specific CRUD features include Enabling / Disabling (status change), Create a Merchant, Update a Merchant (show page)

-- Admin Invoices
  - The Admin Invoices feature perform some CRUD behaviors on Invoices only related to all Merchant records in the db.
  - Updating the Invoice status (on the `admin/invoices/show` page) is done through a model form.
---

### Other features
-- Rake tasks were set up to create Model objects based off supplied .csv files.
  - Once a task was created for each .csv file, they were lumped into a single `rake csv_load:all` command.

-- APIs were explored to display project information from Git Hub

-- A partial has been used _____

## Learning Goals
- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

## Requirements
- must use Rails 5.2.x
- must use PostgreSQL
- all code must be tested via feature tests and model tests, respectively
- must use GitHub branching, team code reviews via GitHub comments, and github projects to track progress on user stories
- must include a thorough README to describe the project
- must deploy completed code to Heroku
- Continuous Integration / Continuous Deployment is not allowed
- Any gems added to the project must be approved by an instructor

## Setup

This project requires Ruby 2.7.4.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## Phases

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md)
