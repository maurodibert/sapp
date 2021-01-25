![Logo](assets/images/micro_logo.png)
# Seri[ou]s
An application for listing TV series, using the API provided by the TVMaze
website.

![demo](assets/gifs/serious_app_demo.gif)


## How to Use 
**Step 1:**
Download or clone this repo by using the link below:
```
```
**Step 2:**
Go to project root and execute the following command in console to get the required dependencies: 
```
flutter pub get 
```
**Step 3:**
Run the app
```
flutter run
```
**APK**
Just download and run in device
```
build/app/outputs/flutter-apk/app-release.apk
```

## :wrench: Libraries & Tools Used
* Provider
* Get It, for dependency injection
* Flutter HTML for rich HTML text

## :mag: Structure
With the separation of concerns in mind, I've built the application applying an MVVM architectural pattern, following the next folder structure:
```
lib
└── core
    └── helpers
    └── models
    └── services
    constants
└── ui
    └── library: reusable components
    └── screens
        └── views: particular UI
        screen: UI
        viewModel: logic

```
At the same time, the code is categorized to make the maintenance easier and pleasurable; 
from scratch, perhaps, could be a little bit cumbersome for an app this small, but as soon as it gets bigger
will make for devs, life much more comfortable. 

## :gift: Extra Features
* UI - UX Design
* Splash Screen
* Icons

## :point_up: Decisions and considerations
**Why those extra features**: I've decided to the *splash screen* and *the icons* as extra features, not following the challenge prioritization because I couldn't devote any more than 18/20 hours in total. In the end, both elements are a fast thing to develop and with a high-value output, letting me give a feeling of a completed app.

**Time devoted to UI/UX basic design**: One of the most critical aspects of an app is the look and feel; it makes a user connect with the app and want to stay and come back. Since I have had many previous technical backgrounds in creative arts, I use them to liberate and decompress.

**Closing the concept - future development**: Some parts of the app should have animations, like the navbars, transition to details, buttons, etc., but the egg always will look, almost without moving, looking at you straight, seriously.