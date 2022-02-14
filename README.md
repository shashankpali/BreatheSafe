# Breathe Safe

`Breathe Safe` will help you to get the update of air quality around the cities in real time so you will be prepare before stepping out.

## Showcase
Breathe safe is adaptive as per you comfort and handle both **light and dark mode, iPhone and iPad**. It supports all the device having **iOS 14.0** and above.
##### Light Mode
|             List              |                       Detail                      |
|-------------------------------|---------------------------------------------------|
|![L_list](https://user-images.githubusercontent.com/11850361/153869640-5583e58d-d663-4045-bcd1-2553492eba9a.png)|![L_detail](https://user-images.githubusercontent.com/11850361/153869650-74085b75-527c-4b6c-a2d5-da33d2eec76a.png)|

##### Dark Mode
|             Step              |                   Description                     |
|-------------------------------|---------------------------------------------------|
|![D_list](https://user-images.githubusercontent.com/11850361/153869389-d35074a2-9e9f-4ef1-ad37-cc574df156e5.png)|![D_detail](https://user-images.githubusercontent.com/11850361/153869417-e9a3b97e-6f04-4b31-b836-111674b8f6aa.png)|

## Speciality
- Real-time AQI updates
- Search functionality help you to get your desire city on your fingure tips
- Scrollable graph to present the trend of AQI in the selected city
- You can manage tracking interval as per your need
- Color update for easy capturing of air quality

## Dependency

Specific module of `BarChart` by [Minh Nguyen](https://github.com/nhatminh12369/BarChart) has been implemented to build the graph and keep the app light weighted

## Architecture
##### Used `MVVM` architecture pattern

![arch_diagram](https://user-images.githubusercontent.com/11850361/153878080-1ac54a85-4d04-4feb-afa6-032c5e2ccfdf.svg)

- Cities List
    - `CitiesAQIViewModel` connect the socket once `Cities list` request for it and pass procced data to dispaly.
    - After receiving callback from `CitiesAQIViewModel`, `Cities List` reload the `UITableView` which builds the `CityAQICell`
    - `CityAQICell` use the reusable `AQIView` which show city detial

- City Details
    - `DetailAQIViewModel` process the history record and set the timer to update the model and pass the procced data to `Cities Details`
    - After receiving callback from `DetailAQIViewModel`, `Cities Details` pass the data to reusable `AQIView` which show city detial and `BarChart` which show graph

- AQIView
    - `AQIView` build the UI for given data
    - `UIColor+Extension` and `String+Extension` are used to get the color for AQI value and condition for status respectively.
    
- CityModel and AQIModel
    - `AQIModel` is used to parse the data in perticular format
    - `CityModel` provide the structure on which app data flow. It also hold the `AQICityRecords` as relationship of **One to Many**

## Logic
- Cities List
    - `CitiesAQIViewModel` looped the parsed array of `AQIModel` and check the existing **Array(citiesAQI)** whether it contains a city with *name*. If it's find the obj `CityModel` it will just update it's *records* else create a new instance of `CityModel` and append it to **citiesAQI**

- City Details
    - Once initiated `DetailAQIViewModel` build an array of `DataEntry` as **arr** from `CityModel`'s `AQICityRecord` and start the timer at default value **30 sec** interval.
    - At every interval the last record from `CityModel`'s `AQICityRecord` gets procced as per `DataEntry` and appeded to **arr**
    - The timer interval value can be modified by user

- WebSocket 
    - Create a single instance of `WebSocket` so when app *sceneDidEnterBackground* get called disconnecting the scoket and re-connecting it at callback *sceneWillEnterForeground*

## I hope you will like the Project..!!!
