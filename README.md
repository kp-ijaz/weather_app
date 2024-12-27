# Weather App

A simple Flutter application that fetches and displays weather data for a city entered by the user. The app allows users to view the current weather conditions, including temperature, humidity, wind speed, and more. The app also supports recent city search history and uses the Bloc pattern for state management.

## Features

- **City Search**: Users can enter a city name to retrieve its weather information.
- **Autocomplete Search**: As the user types, suggestions based on previously searched cities are displayed.
- **Recent City History**: The app keeps track of the last 5 searched cities and displays them as suggestions.
- **Weather Details**: Displays weather information such as temperature, humidity, wind speed, and more.
- **State Management**: Uses Bloc for managing weather-related states (Loading, Loaded, Error).

## Technologies Used

- **Flutter**: A UI toolkit for building natively compiled applications.
- **Bloc Pattern**: For managing state across the app using `flutter_bloc` library.
- **SharedPreferences**: For persisting recent cities list.
- **Weather API**: The app fetches weather data from a weather API (e.g., OpenWeatherMap, WeatherStack, etc.).

## Setup and Installation

### Clone the repository:

```bash
git clone https://github.com/kp-ijaz/weather_app.git
cd weather_app
```

###Install dependencies:
```bash
flutter pub get
```
Replace the API_KEY in the weather API calls with your own API key (if you're using an external weather API like OpenWeatherMap).

Run the app:

```bash
flutter run
```

###Usage

- **City Search**: Start typing the name of a city in the search bar, and it will show suggestions based on previously searched cities.
- **View Weather**: After entering a city, the app will show the current weather details such as temperature, humidity, and wind speed.
- **Clear Search**: You can clear the search bar to remove any input.

###Project Structure

- lib/:
- bloc/: Contains the Bloc files, including the events, states, and the business logic for weather data.
- view/: Contains the UI code, including widgets for weather details, search bar, and recent cities.
- main.dart: The entry point of the app.
- assets/: Contains image assets for the app (e.g., weather icons).
