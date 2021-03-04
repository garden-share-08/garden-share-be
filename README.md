![](https://img.shields.io/badge/Rails-5.2.4-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a) ![](https://img.shields.io/badge/Ruby-2.5.3-orange) ![Heroku](https://heroku-badge.herokuapp.com/?app=heroku-badge)

# Garden-Share: BackEnd

## Overview

This repository represents the backend portion of a capstone project for the Turing School of Software & Design.

Garden-Share is an application designed to function as a produce swap meet...

All of the repositories that make up this project can be found [here](https://github.com/garden-share-08)

## Table of Contents
  - [Design](#design)
  - [Schema](#schema)
  - [Setup](#setup)
  - [Testing](#testing)
  - [Deployment](#deployment)
  - [Authors](#authors)

### Design

Garden-Share utilizes a service-orriented architecture to ensure future scalability.

The back-end is written primarily in Ruby on Rails/GrahphQL and deployed via [Heroku](https://garden-share-be.herokuapp.com/)

The front-end is written primarily in JavaScript/Node.js and is deployed via [Heroku](FE URL Needed!)

The microservice is written primarily in Python/Flask and is deployed via [Heroku](https://gardeen-location-microservice.herokuapp.com/)

To see all available endpoints the `Garden-Share-BE.postman_collection.json` file (located in the root directory) can be imported into Postman.

### Schema 

<img width="717" alt="Garden-Share-BE-Schema" src="https://user-images.githubusercontent.com/63476564/109400683-054c6200-7918-11eb-9f25-f02b141ad0a5.png">

### Setup
#### Prerequisites
These setup instructions are for Mac OS.

This project requires the use of `Ruby 2.5.3` and `Rails 5.2.4.3`.
We also use `PostgreSQL` as our database.

##### Install Necessary Programs

1. Verify your machine has the correct version of Ruby installed (2.5.3).  You can check this by entering `ruby -v` from the command line.
    - To install, enter `rbenv install 2.5.3` from the command line.   

2. Verify your machine has the correct version of Rails installed (5.2.4.3).  You can check this by entering `rails -v` from the command line.
    - To install, enter `gem install rails -v 5.2.3` from the command line.

##### Local Repo Setup
1. Fork & Clone Repo
2. Run `bundle install`.
3. From the command line, install gems and set up your DB:
    * `bundle install`
    * `rails db:create`
    * `rails db:migrate`
4. Install Figaro with `bundle exec figaro install` to create an application.yml file locally
5. Add `ZIPCODE_MICROSERVICE_BASE_URL: 'https://garden-share-be.herokuapp.com/'` to the application.yml file

### Testing 

This app utilizes [Travis CI](travis-ci.com) for integrated testing.

Run the test suite with `bundle exec rspec`

#### The Garden Share BE utilizes the following gems and libraries in testing:
 
- [WebMock](https://github.com/bblimke/webmock)
- [FactoryBot](https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md)
- [Faker](https://github.com/faker-ruby/faker)
- [ShouldaMatchers](https://github.com/thoughtbot/shoulda-matchers)
- [SimpleCov](https://github.com/simplecov-ruby/simplecov)

### Deployment

For local deployment run your development server with `rails s` and visit [localhost:3000](http://localhost:3000) to see the app in action.

For accessing the microservice you can run `rails s` and visit [localhost:3001](http://localhost:3001) and include `ZIPCODE_MICROSERVICE_BASE_URL: 'http://localhost:3001/'` in the application.yml file

[Garden Share](https://garden-share-be.herokuapp.com/) is deployed remotely via Heroku

### Authors
  - **Aaron Townsend** - *Turing Student* - [GitHub Profile](https://github.com/atownse) - [LinkedIn](https://www.linkedin.com/in/aaron-townsend-667604176/)
  - **Bruce Gordon** - *Turing Student* - [GitHub Profile](https://github.com/bruce-gordon) - [Turing Alum Portfolio](https://alumni.turing.io/alumni/bruce-gordon) - [LinkedIn](https://www.linkedin.com/in/brucemgordon/)
  - **Chadrick Dickerson** - *Turing Student* - [GitHub Profile](https://github.com/chadrick-d-dev) - [Turing Alum Portfolio](https://alumni.turing.io/alumni/chadrick-dickerson) - [LinkedIn](https://www.linkedin.com/in/chadrick-dickerson/)
  - **Christopher Allbritton** - *Turing Student* - [GitHub Profile](https://github.com/Callbritton) - [Turing Alum Portfolio](https://alumni.turing.io/alumni/christopher-allbritton) - [LinkedIn](https://www.linkedin.com/in/christopher-allbritton)
  - **Dani Coleman** - *Turing Student* - [GitHub Profile](https://github.com/dcoleman21) - [Turing Alum Portfolio](https://alumni.turing.io/alumni/dani-coleman) - [LinkedIn](https://www.linkedin.com/in/dcoleman-21/)
  - **Joshua Carey** - *Turing Student* - [GitHub Profile](https://github.com/jdcarey128) - [Turing Alum Portfolio](https://alumni.turing.io/alumni/joshua-carey) - [LinkedIn](https://www.linkedin.com/in/carey-joshua/)
