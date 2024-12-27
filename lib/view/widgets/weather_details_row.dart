import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
// import 'package:weather_app/models/weather.dart';

class WeatherDetailsRow extends StatelessWidget {
  final Weather weather;

  const WeatherDetailsRow({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildDetailItem('Humidity', '${weather.humidity}%', Icons.water_drop),
        _buildDetailItem('Wind', '${weather.windSpeed} km/h', Icons.air),
        _buildDetailItem(
            'Feels Like', '${weather.feelsLike}°', Icons.thermostat),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
