Stargazing Conditions app 
===

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

This app fetches data from astronomy and weather APIs for the current day or week and returns them, combining everything that a stargazer needs to watch for before choosing a day to go out. Shows the clarity of the sky for the day (clouds, light pollution) and also the brightest/most visible stars and astral bodies. Can choose between different days of the week and viewing locations. 

### App Evaluation

[Evaluation of your app across the following attributes]
- **Category:** Educational
- **Story:** Pull up the app to check for ideal conditions to spot celestial bodies in the sky. 
- **Market:** This app is for anyone with a telescope or any casual stargazers who want a summary for the most ideal conditions to practice their hobby.
- **Habit:** A single interface to see *everything* relating to stargazing instead of needing to swap between weather and astronomy sites.
- **Scope:** V1 only consists of basic interfaces, being able to swap between different pages. All styling and UX/UI should be done at this point. V2 implements basic weather information for the week (cloud coverage, sundown times, light pollution) on the landing page. By clicking one day, the user is redirected to another page to view elaborated weather info and astronomy info. V3 expands on the astronomy API, adding the ability to return astral body data for each day (degrees of bodies, setting/rising times, altitude). This data should update with the weather API. V4 should allow for data to be updated depending on what location the user chooses from.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

1. Weather data and brief astronomy data on the front page (cloud coverage, sundown times, temperature, light pollution).
2. After choosing a day, detailed astronomy is returned (degrees of bodies, setting/rising times, altitude of bodies).
3. User can scrub through days of the week and see information for those days.
4. Data updates in real time after a select time interval.

**Optional Nice-to-have Stories**

* Change locations

### 2. Screen Archetypes

- [ ] Landing page
    * Displays brief weekly forecast
    * (Optional) Button to access location change
- [ ] Day details
    - [ ] Altitude graph (astral body visibility)
    - [ ] Extended weather
    - [ ] Constellation view

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Landing page
* Day details

**Flow Navigation** (Screen to Screen)

- [ ] Landing page
* => Day details
- [ ] Day details
* => Altitude graph (astral body visibility)
* => Extended weather
* => Constellation view
* => Landing page

## Wireframes

<img src="https://github.com/embrub/stargazing-conditions/blob/a6fd542100e5c464238604e84fa866e48d62f957/IMG_2497.jpg" width=710>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype
 
## Schema 

[This section will be completed in Unit 9]

### Models

[Add table of models]

### Networking

- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
