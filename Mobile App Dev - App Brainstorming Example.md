Mobile App Dev - App Brainstorming
===

## New App Ideas - List
1. Sleep debt calculator
    * Users can log how much sleep they've had for each day of the month. The app calculates the user's monthly/weekly hours of sleep and reccomends a sleep schedule based on their input.
2. Stargazing conditions app
    * Fetch data from astronomy and weather APIs and return them. Shows the day's conditions in the sky (clouds, light pollution) and also the brightest/most visible stars and astral bodies. Can see ahead into the week to see the most ideal days to take out your telescope. Can change viewing location. 
    * **Possible APIs to pull from:**
        * https://www.weatherapi.com/api.aspx
        * http://cdsarc.u-strasbg.fr/viz-bin/cat/V/50 (The Bright Star Catalogue)
        * https://www.arcsecond.io (observatories)
        * http://open-notify.org (satelites)
        * https://www.cleardarksky.com/c/WnrObAZkey.html?1 & http://www.7timer.info/doc.php (clear sky chart)
        * https://www.meteoblue.com/en/weather/outdoorsports/seeing/charlotte_united-states_4460243 (clouds) (best bet)
            * https://www.meteoblue.com/en/weather/widget/setupseeing/charlotte_united-states_4460243
        * https://nightlight.edwardpeterson.dev/?longitude=-79.5374591&latitude=38.7160523&date=4-3 (ref)
3. Bookmarks/Corkboard app
    * Save links and photos from other apps or directly from your camera roll and sort these items in folders, lists, or a corkboard. Customize descriptions and appearances.
4. (Alternative to the prior idea) -- Bluesky bookmarks (iOS edition)
    * There are multiple different browser extensions that imitate Twitter's bookmarking function on Bluesky which doesn't have one. But there's no iOS equivalent to this, we could try making our own. 
6. Mood tracker
    * Calendar app with journaling feature - mark a mood for the day after clicking a calendar square. Option to access a journal interface to take notes for that day. The user can view a summary panel of color-coded moods through the week/month/year.
7. Recipie tracker
    * Log groceries, ingredients, recipies and shopping lists: build your own personal recipie book.

## Top 3 New App Ideas
1. Stargazing conditions app
2. Sleep debt calculator
3. Mood tracker

## New App Ideas - Evaluate and Categorize
1. Stargazing conditions app
   - **Description**: Fetch data from astronomy and weather APIs and return them. Shows the day's conditions in the sky (clouds, light pollution) and also the brightest/most visible stars and astral bodies. Can see ahead into the week to see the most ideal days to take out your telescope. Can change viewing location. 
   - **Category:** Educational
   - **Mobile:** A user has quick access to an interface to view the sky's conditions, even while outside.
   - **Story:** Pull up the app to check for most ideal setting and time to spot celestial bodies in the sky. 
   - **Market:** Anyone with a telescope or hobbyist stargazers who want a summary for the most ideal conditions to practice their hobby.
   - **Habit:** A single interface to see *everything* relating to stargazing instead of needing to swap between weather apps and astronomy apps.
   - **Scope:** V1 only consists of basic interfaces, being able to swap between views. The landing screen should have basic weather information (cloud coverage, sundown times, light pollution). V3 integrates the astronomy API, adding the ability to display astral body data (degrees, setting/rising times, altitude for planets). This data should update consistently with the weather API. V4 should allow for data to be updated depending on what location the user chooses from.
2. Sleep debt calculator
   - **Description**: Users can log how much sleep they've had for each day of the month. The app calculates the user's monthly/weekly hours of sleep and reccomends a sleep schedule based on their input.
   - **Category:** Health
   - **Mobile:** With a mobile interface, it's easy to access right when you wake up, and can be timed to remind you of healthy habits before going to bed.
   - **Story:** The app is used to aid the user’s quality of life by keeping track of hours slept per night and suggests a healthy schedule based on what you log. 
   - **Market:** The app is for those who have trouble with a consistent sleep schedule or who would just like to track their hours. 
   - **Habit:** Logging entries every day after waking up, reading your suggested habits and using the app to catch up on sleep debt. 
   - **Scope:** For V1, the program contains a calendar-- each box contains the hours of sleep logged for that day, and the amount of sleep suggested. V2, have it so that when a box is clicked, you can log/edit the amount of sleep entered that day. Upon logging a day, suggestions will appear for the rest of the month about how much sleep you should get. Data should persist. V3 should have a new view which shows the user statistics about their sleep habits, sleep debt, and reccomendations. V4 should have the ability to view your hours in a graph format. 

  
## Final App Idea
* Stargazing Conditions App
