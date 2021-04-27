# SweaterWhether

## About this Project
SweaterWhether offers users location-based weather information regarding their road trip destination.

## Acknowledgements
- Thanks to [Pexels Image Search API](https://www.pexels.com/) for background image endpoint
- Thanks to [OpenWeather OneCall API](https://openweathermap.org/api/one-call-api) for weather forecast endpoints

## Table of Contents

- [Getting Started](#getting-started)
- [Running the tests](#running-the-tests)
- [Other Repos](#other-repos)
- [Built With](#built-with)
- [Versioning](#versioning)
- [Authors](#authors)
- [Acknowledgments](#acknowledgments)

## Getting Started

To get the web application running, please fork and clone down the repo.


`git clone <your@github.account:SweaterWhether.git>`

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

## Endpoints

##### Climate Data - current, 5-day, hourly (8 hours)
- **Required** query params:
  - `location`

`GET /api/v1/forecast?location={loc}`

```json
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "datetime": "2021-04-27T17:13:24.000-06:00",
                "sunrise": "2021-04-27T06:14:08.000-06:00",
                "sunset": "2021-04-27T20:10:38.000-06:00",
                "temperature": 48.74,
                "feels_like": 46.99,
                "humidity": 61,
                "uvi": 1.91,
                "visibility": 10000,
                "conditions": "overcast clouds",
                "icon": "04d"
            },
            "daily_weather": [
                {
                    "date": "2021-04-27",
                    "sunrise": "2021-04-27T06:14:08.000-06:00",
                    "sunset": "2021-04-27T20:10:38.000-06:00",
                    "max_temp": 48.78,
                    "min_temp": 36.79,
                    "conditions": "rain and snow",
                    "icon": "13d"
                },
                {
                    "date": "2021-04-28",
                    "sunrise": "2021-04-28T06:12:42.000-06:00",
                    "sunset": "2021-04-28T20:11:48.000-06:00",
                    "max_temp": 60.91,
                    "min_temp": 37.89,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "date": "2021-04-29",
                    "sunrise": "2021-04-29T06:11:18.000-06:00",
                    "sunset": "2021-04-29T20:12:57.000-06:00",
                    "max_temp": 68.52,
                    "min_temp": 44.15,
                    "conditions": "few clouds",
                    "icon": "02d"
                },
                {
                    "date": "2021-04-30",
                    "sunrise": "2021-04-30T06:09:55.000-06:00",
                    "sunset": "2021-04-30T20:14:06.000-06:00",
                    "max_temp": 75.51,
                    "min_temp": 51.96,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "date": "2021-05-01",
                    "sunrise": "2021-05-01T06:08:33.000-06:00",
                    "sunset": "2021-05-01T20:15:15.000-06:00",
                    "max_temp": 69.93,
                    "min_temp": 55.02,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                }
            ],
            "hourly_weather": [
                {
                    "time": "17:00:00",
                    "temperature": 48.74,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "time": "18:00:00",
                    "temperature": 48.78,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "time": "19:00:00",
                    "temperature": 48.52,
                    "conditions": "broken clouds",
                    "icon": "04d"
                },
                {
                    "time": "20:00:00",
                    "temperature": 46.76,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "time": "21:00:00",
                    "temperature": 44.1,
                    "conditions": "broken clouds",
                    "icon": "04n"
                },
                {
                    "time": "22:00:00",
                    "temperature": 42.78,
                    "conditions": "broken clouds",
                    "icon": "04n"
                },
                {
                    "time": "23:00:00",
                    "temperature": 41.65,
                    "conditions": "broken clouds",
                    "icon": "04n"
                },
                {
                    "time": "00:00:00",
                    "temperature": 40.91,
                    "conditions": "scattered clouds",
                    "icon": "03n"
                }
            ]
        }
    }
}
```

##### City Background Image
- **Required** query params:
  - `location`

`GET /api/v1/backgrounds?location={loc}`

```json
{
    "data": {
        "id": null,
        "type": "image",
        "attributes": {
            "url": "https://www.pexels.com/photo/wide-angle-photography-of-city-near-body-of-water-702343/",
            "photographer": "Anon",
            "photographer_url": "https://www.pexels.com/@anon-213834",
            "src": "https://images.pexels.com/photos/702343/pexels-photo-702343.jpeg",
            "credit": "All image credit goes to Pexels.com and the photographer. This is an educational project only."
        }
    }
}
```

##### Registration - POST
- **Required** JSON body:
 ```json
    {
    "email": "xx@beep.com",
    "password": "flame",
    "password_confirmation": "flame"
    }
 ```

`POST /api/v1/users

```json
{
    "data": {
        "id": "3",
        "type": "users",
        "attributes": {
            "email": "xx@beep.com",
            "api_key": "c7dbb4533fb8fb7b8c44"
        }
    }
}
```

##### Login - POST
- **Required** JSON body:
 ```json
    {
    "email": "xx@beep.com",
    "password": "flame",
    }
 ```

`POST /api/v1/sessions

```json
{
    "data": {
        "id": "3",
        "type": "users",
        "attributes": {
            "email": "xx@beep.com",
            "api_key": "c7dbb4533fb8fb7b8c44"
        }
    }
}
```

##### Raodtrip - POST
- **Required** JSON body:
 ```json
    {
    "origin": "denver, co",
    "destination": "fort myers, fl",
    "api_key": "c7dbb4533fb8fb7b8c44"
    }
 ```

`POST /api/v1/sessions

```json
{
    "data": {
        "id": null,
        "type": "roadtrip",
        "attributes": {
            "start_city": "denver, co",
            "end_city": "fort myers, fl",
            "travel_time": "29 hours, 2 minutes",
            "weather_at_eta": {
                "temperature": 72.66,
                "conditions": "scattered clouds"
            }
        }
    }
}
```



## Built With

- [Ruby](https://www.ruby-lang.org/en/)
- [RSpec](https://github.com/rspec/rspec)
- [Rbenv](https://github.com/rbenv/rbenv)


## Versioning
- Rails 5.2.5
- Ruby 2.5.3
- RSpec 3.10.0
- Rbev 1.1.2

## Author

- **Wil McCauley**
|    [GitHub](https://github.com/wil-mcc) |
    [LinkedIn](https://www.linkedin.com/in/wil-mccauley/)
    
