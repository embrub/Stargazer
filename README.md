Stargazing Conditions app 
===

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description
This app fetches data from astronomy and weather APIs from for the current day or week and returns them, combining everything that a stargazer needs to watch for before choosing a day to go out. Shows the clarity of the sky for the day (clouds, light pollution) and also the brightest/most visible stars and astral bodies. Can choose between different days of the week and viewing locations. 

### App Evaluation
- **Category:** Educational
- **Story:** Pull up the app to check for ideal conditions to spot celestial bodies in the sky. 
- **Market:** This app is for anyone with a telescope or any casual stargazers who want a summary for the most ideal conditions to practice their hobby.
- **Habit:** A single interface to see *everything* relating to stargazing instead of needing to swap between weather and astronomy sites.
- **Scope:** V1 only consists of basic interfaces, being able to swap between different pages. All styling and UX/UI should be done at this point. V2 implements basic weather information for the week (cloud coverage, sundown times, light pollution) on the landing page. By switching tabs, the user is redirected to another page to view elaborated astronomy info. V3 expands on the afforementioned page, adding the ability to return astral body data for the day. This data should update with the weather API.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

1. Weather data and brief astronomy data on the front page (cloud coverage, temperature,etc).
2. Detailed astronomy data is returned (degrees of bodies, setting/rising times, altitude of bodies).
4. Data updates in real time.

**Optional Nice-to-have Stories**

* Change locations

### 2. Screen Archetypes

- [x] Landing page
    * Displays brief weekly forecast
    * (Optional) Button to access location change
- [x] Day details
    - [x] Altitude graph (astral body visibility)
    - [x] Events list

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Landing page
* Day details

**Flow Navigation** (Screen to Screen)

- [x] Landing page
    * => Day details
- [x] Day details
    * => Altitude graph (astral body visibility)
    * => Events view
    * => Landing page

## Wireframe

<img src="https://github.com/embrub/Stargazer/blob/5570a1ca18ea07beb4313b8132271f0722c48a85/Misc/wireframe.jpg" width=710>

## Sprint 1
<img src="https://github.com/embrub/Stargazer/blob/main/Misc/final.gif" width=710>
(April 1-5)
* switch to hard-coding pages in UIkit instead of Storyboard (following tutorials from Mitchell Hudson, iOS Academy, CodeBrah)
* tab navigation & navigation bar integrated
* UI for weather page done
* fetch user coordinates successfully

## Sprint 2
(April 6-12)
Forgot to push to github, but these were the following changes:
* created landing page to ask location permissions.
* integrated API with the "weather" page.
* completed UI and API fetching for "events" page.
* "add event to calendar" functionality to "events" page
* completed UI for "celestial" page (following tutorials from Karin Prater, Swiftful Thinking)

## Sprint 3
<img src="https://github.com/embrub/Stargazer/blob/e84789961094ce02cad6a9bbb74b52354a1e5991/Misc/final.gif" width=710>

(April 13-16)
* API integration into "celestials" page, line graph is rendered properly
* hide/unhide line functions
* calculate good, OK, bad conditions for the "weather" page

## Models

### LocationDate
A shared class which allows the user's coordinates to be passed between Views. 
* ```shared```: default LocationDate() declaration
* ```longitude```: represents the longitude from  LocationDate()
* ```latitude```represents the latitude from  LocationDate()
### AltitudeData
This structure represents a celestial object and its altitude in the sky at a specific point in time. 
* ```hour```: hour coresponding to the data point
* ```altitude```: altitude of the celestial object
* ```object```: name of the celestial object
### Forecast
Represents the sky conditions for the day. Utilizes Decodable & CodingKeys to conform fetched API data to the struct format. 
* ```timepoint```: represents the hour correlating to the fetched data
* ```cloudcover```: cloud cover during the hour
* ```seeing```: atmospheric seeing (level of light scattering of an astral body due to the atmosphere)
* ```transparency```: atmospheric transparency (the current clarity of the atmosphere)
* ```liftedIndex```: atmospheric instability (the stability of the current weather conditions)
* ```rh2m```: relative humidity during the hour
* ```temp2m```: temperature during the hour
* ```precType```: percipitation type during the hour
### Event
Struct to format all astronomical events. It conforms to Codable protocols.
* ```date```: month and day of the event
* ```title```: title of the event
* ```content```: event description
* ```image```: image url (unused)
### Networking

#### APIs Used:
* 7Timer astro data (astro weather)
    * https://7timer.info/index.php?product=astro&lon=14.398&lat=47.911&lang=en&ac=0&unit=metric&tzshift=0&site=
* AstronomyAPI (planet altitudes)
    * https://api.astronomyapi.com/api/v2/bodies/positions
* Rapidapi astronomy calendar (events)
    * https://rapidapi.com/sharmadhirajnp2/api/astronomy-calendar