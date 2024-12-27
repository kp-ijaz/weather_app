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
git clone https://github.com/yourusername/weather-app.git
cd weather-app
