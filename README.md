# Sweater Weather

Sweater Weather is the final solo project for [Turing School of Software and Design](https://turing.io/) Backend Mod 3 Students. Students had a 5 day deadline to complete all functionality.

## Project Description 

Your backend is building an application to plan road trips. This app will allow users to see the current weather as well as the forecasted weather at the destination. Your team is working in a service-oriented architecture. The frontend will communicate with your backend through an API. You job is to expose that API that satisfies the frontend team's requirements.

## Learning Goals
* Expose an API that aggregates data from multiple external APIs
* Expose an API that requires an authentication token
* Expose an API for CRUD functionality
* Determine completion criteria based on the needs of other developers
* Research, select, and consume an API based on your needs as a developer

## Setup

* Clone down the repo to your local machine
  * `bundle install`
  * `rails db:{create,migrate}`

### API Keys

Run `figaro install` to auto-create/.girignore your `config/application.yml` file. Sign up for the following API Keys and add them into your file as follows:

#### [MapQuest](https://developer.mapquest.com/plan_purchase/steps/business_edition/business_edition_free/register)
```
MAPQUEST_API_KEY: "insert_your_key_here"
```

#### [OpenWeather](https://home.openweathermap.org/users/sign_up)
```
OPEN_WEATHER_API_KEY: "insert_your_key_here"
```

## See Endpoints Locally

Run `rails s` to start the local server. Using any API platform, such as [Postman](https://www.postman.com/downloads/), run the desired endpoint with the base URL of `http://localhost:300/api/v1/#{desired_endpoint}`. Make sure to include your API based off the developer documentation per each key. 

## Testing

Sweater Weather is tested with RSpec. To run the test suite, run `bundle exec rspec`
