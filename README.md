# SweaterWhether

## About this Project
SweaterWhether offers users location-based weather information regarding their road trip destination. 

## Table of Contents

- [Getting Started](#getting-started)
- [Running the tests](#running-the-tests)
- [Other Repos](#other-repos)
- [Built With](#built-with)
- [Contributing](#contributing)
- [Versioning](#versioning)
- [Authors](#authors)
- [Acknowledgments](#acknowledgments)

## Getting Started

To get the web application running, please fork and clone down the repo.


`git clone <your@github.account:WeatherVine/front_end.git>`

### Prerequisites

To run this application you will need Ruby 2.5.3 and Rails 5.2.5

### Installing

- Install the gem packages  
  - `bundle install`
- Generate your local `application.yml` file to store the api keys and confirm it was added to your `.gitignore`
  - `bundle exec figaro install`

## Running the tests
RSpec testing suite is utilized for testing this application.
- Run the RSpec suite to ensure everything is passing as expected  
`bundle exec rspec`

## Service Oriented Architecture


## Endpoints

##### Climate Data
- **Required** query params:
  - `location`

`GET /api/v1/forecast?location={loc}`

```json
{
  data: {
    "id": null,
    "type": "forecast",
    "attributes": {
      "current_weather": { },
      "daily_weather": { },
      "hourly_weather": { }
    }
  }
}
```

## Built With

- [Ruby](https://www.ruby-lang.org/en/)
- [RSpec](https://github.com/rspec/rspec)
- [Rbenv](https://github.com/rbenv/rbenv)

## Contributing
Please follow the steps below and know that all contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/<New-Cool-Feature-Name>`)
3. Commit your Changes (`git commit -m 'Add <New-Cool-Feature-Name>'`)
4. Push to the Branch (`git push origin feature/<New-Cool-Feature-Name>`)
5. Open a Pull Request

## Versioning
- Rails 5.2.5
- Ruby 2.5.3
- RSpec 3.10.0
- Rbev 1.1.2

## Author

- **Wil McCauley**
|    [GitHub](https://github.com/wil-mcc) |
    [LinkedIn](https://www.linkedin.com/in/wil-mccauley/)
    
## Acknowledgements
- Thanks to [Pexels Image Search API](https://www.pexels.com/) for background image endpoint
- Thanks to [OpenWeather OneCall API](https://openweathermap.org/api/one-call-api) for weather forecast endpoints
