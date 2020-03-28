# Weather-SwiftUI-MVVM

This application fetches weather forecast from openweathermap API and displays data. I includes feature like showing 5 days and 3 hours weather forecast data of the current location. you can search current weather of minimum 3 and maximum 7 cities at a time. 

## Demonstrations

Covers the following:

* Frameworks/Tools used
* Discussions
* Screenshots
* Architecture 
* Installation
* Unit Tests and Coverage

## Frameworks/Tools used:

* SwiftUI
* MVVM 
* Combine Framework
* Clubbing multiple network requests using Combine `mergeAll` feature.
* XCTest Framework 

## Discussions

I have used `SwiftUI` for user interface creation, `Combine framework` allows me to use features like Observable, states, publishers and subscribers. `MVVM` design pattern helped me to use features like less code, more decoupling, modular approach, easy to test, Bindings make UI updates easier to handle, ease of maintainability etc.    

## Screenshots

|             Current Weather         |         Weather Forecast          | 
|---------------------------------|------------------------------|
|![Demo](https://github.com/mwaqasbhati/Weather-SwiftUI-MVVM/blob/master/screenshots/Weather.png)|![Demo](https://github.com/mwaqasbhati/Weather-SwiftUI-MVVM/blob/master/screenshots/Forecast.png)|

## Requirements

- Xcode 11.3.1
- Swift 5.0
- Minimum iOS version 13.2


## Architecture at a Glance

![Architecture at a Glance](https://github.com/mwaqasbhati/Weather-SwiftUI-MVVM/blob/master/Architecture/MVVM.png)

## Installation

Checkout this repository, go to project directory, open it and run using Xcode.

## Build

To build using xcodebuild without code signing
```
xcodebuild clean build -scheme "WeatherAPI-SwiftUI-MVVM" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO CODE_SIGNING_ALLOWED=NO
```

## Tests

To run tests using xcodebuild.
```
xcodebuild -scheme "WeatherAPI-SwiftUI-MVVM" -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 11 Pro Max,OS=13.3' test

```
## Coverage

> * Note: Test Coverage is less because Apple has not given any thing yet to test Swift View Classes

![Test Cases and Coverage](https://github.com/mwaqasbhati/Weather-SwiftUI-MVVM/blob/master/screenshots/Coverage.png)


## Author

mwaqasbhati, m.waqas.bhati@hotmail.com

## License

Weather-SwiftUI-MVVM is available under the MIT license. See the LICENSE file for more info.

