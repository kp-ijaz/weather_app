import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/bloc/weather_event.dart';
import 'package:weather_app/bloc/weather_state.dart';
import 'package:weather_app/view/widgets/weather_details_row.dart';
import 'package:weather_app/view/widgets/weather_info_card.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<String> _recentCities = [];

  @override
  void initState() {
    super.initState();
    _loadRecentCities();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  Future<void> _loadRecentCities() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _recentCities = prefs.getStringList('recentCities') ?? [];
    });
  }

  Future<void> _saveCity(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    if (!_recentCities.contains(cityName)) {
      _recentCities.insert(0, cityName);
      if (_recentCities.length > 5) {
        _recentCities = _recentCities.sublist(0, 5);
      }
      await prefs.setStringList('recentCities', _recentCities);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade900,
              Colors.blue.shade800,
              Colors.blue.shade700,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSearchBar(context),
                      const SizedBox(height: 20),
                      Expanded(
                        child: BlocBuilder<WeatherBloc, WeatherState>(
                          builder: (context, state) {
                            if (state is WeatherInitial) {
                              return const Center(
                                child: Text(
                                  'Enter a city name to get weather info.',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              );
                            } else if (state is WeatherLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              );
                            } else if (state is WeatherLoaded) {
                              return _buildWeatherInfo(state);
                            } else if (state is WeatherError) {
                              return Center(
                                child: Text(
                                  state.message,
                                  style:
                                      const TextStyle(color: Colors.redAccent),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return _recentCities;
        } else {
          return _recentCities
              .where((city) => city
                  .toLowerCase()
                  .startsWith(textEditingValue.text.toLowerCase()))
              .toList();
        }
      },
      onSelected: (String cityName) {
        _cityController.text = cityName;
        _saveCity(cityName);
        context.read<WeatherBloc>().add(FetchWeather(cityName));
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        _cityController.text = textEditingController.text;
        return Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(36, 255, 255, 255).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: textEditingController,
            focusNode: focusNode,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Enter City Name',
              hintStyle: const TextStyle(color: Colors.white60),
              border: InputBorder.none,
              icon: const Icon(Icons.location_city, color: Colors.white70),
              suffixIcon:
                  _focusNode.hasFocus && textEditingController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.white70),
                          onPressed: () {
                            textEditingController.clear();
                            _cityController.clear();
                          },
                        )
                      : null,
            ),
            onSubmitted: (value) {
              final cityName = value.trim();
              if (cityName.isNotEmpty) {
                _saveCity(cityName);
                context.read<WeatherBloc>().add(FetchWeather(cityName));
                FocusScope.of(context).unfocus();
              }
            },
          ),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) {
                final city = options.elementAt(index);
                return ListTile(
                  title:
                      Text(city, style: const TextStyle(color: Colors.black)),
                  onTap: () {
                    onSelected(city);
                    FocusScope.of(context).unfocus();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildWeatherInfo(WeatherLoaded state) {
    return Column(
      children: [
        const SizedBox(height: 50),
        WeatherInfoCard(weather: state.weather),
        const SizedBox(height: 30),
        WeatherDetailsRow(weather: state.weather),
      ],
    );
  }
}
