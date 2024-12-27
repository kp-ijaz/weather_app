class WeatherUtils {
  static String getWeatherAnimation(String condition) {
    condition = condition.toLowerCase();

    if (condition.contains('rain') || condition.contains('drizzle')) {
      return 'assets/images/rainy.json';
    } else if (condition.contains('cloud')) {
      return 'assets/images/cloudy.json';
    } else if (condition.contains('snow')) {
      return 'assets/images/snowy.json';
    } else if (condition.contains('thunder') || condition.contains('storm')) {
      return 'assets/images/thunder.json';
    } else if (condition.contains('clear')) {
      return 'assets/images/sunny.json';
    } else {
      return 'assets/images/default.json';
    }
  }
}
