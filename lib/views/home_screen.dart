import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data/services/api_services.dart';
import 'package:weather_app/data/services/geo_location.dart';
import 'package:weather_app/res/widget/adittionalinfo_item.dart';
import 'package:weather_app/res/widget/time_houri_tem.dart';

class HomeScrreen extends StatefulWidget {
  const HomeScrreen({super.key});

  @override
  State<HomeScrreen> createState() => _HomeScrreenState();
}

class _HomeScrreenState extends State<HomeScrreen> {
  ApiServices apiService = ApiServices();

  final LocationManager locationManager = LocationManager();

  Map? weatherData;

  @override
  void initState() {
    fetchWeatherData();
    super.initState();
  }

  Future<void> fetchWeatherData() async {
    try {
      Position currentPosition = await locationManager.getCurrentLocation();
      Map data = await apiService.getWeatherByCoordinates(currentPosition);

      setState(() {
        weatherData = data;
      });
    } catch (e) {
      throw e.toString();
    }
  }

  double kelvinToCelsius(double kelvin) {
    final weather = kelvin - 273.15;
    return double.parse(weather.toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Weather App"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: () {
                fetchWeatherData();
              },
              icon: const Icon(Icons.refresh),
            ),
          )
        ],
      ),
      body: weatherData == null
          ? const Center(child: CircularProgressIndicator.adaptive())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display current weather information
                  // Text(
                  //   ' ${weatherData!['city']['name']}',
                  //   style: const TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 20,
                  //   ),
                  // ),

                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              '${kelvinToCelsius(weatherData!['list'][0]['main']['temp'])} °C',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Icon(
                              weatherData!['list'][0]['weather'][0]['main'] ==
                                          'Clouds' ||
                                      weatherData!['list'][0]['weather'][0]
                                              ['main'] ==
                                          'Rain'
                                  ? Icons.cloud
                                  : Icons.sunny,
                              size: 48,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '${weatherData!['list'][0]['weather'][0]['main']}',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Weather Forecast',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        final forecastTime = weatherData!['list'][index + 1];
                        final hourSky = forecastTime['weather'][0]['main'];
                        final hourTime = forecastTime['dt_txt'];
                        final hourTemp = forecastTime['main']['temp'];
                        final formattedTime =
                            DateFormat.j().format(DateTime.parse(hourTime));
                        final changeWeatherToCelsius =
                            kelvinToCelsius(hourTemp);

                        return TimeHourItem(
                          time: formattedTime,
                          text: '$changeWeatherToCelsius °C',
                          icon: Icon(
                            hourSky == 'Clouds' || hourSky == 'Rain'
                                ? Icons.cloud
                                : Icons.sunny,
                            size: 32,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Additional Information',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AdditionalInfoitem(
                        icon: const Icon(
                          Icons.water_drop,
                          size: 27,
                        ),
                        value: '${weatherData!['list'][0]['main']['humidity']}',
                        title: 'Humidity',
                      ),
                      AdditionalInfoitem(
                        icon: const Icon(
                          Icons.air,
                          size: 27,
                        ),
                        value: '${weatherData!['list'][0]['wind']['speed']}',
                        title: 'Wind Speed',
                      ),
                      AdditionalInfoitem(
                        icon: const Icon(
                          Icons.beach_access,
                          size: 27,
                        ),
                        value: '${weatherData!['list'][0]['main']['pressure']}',
                        title: 'Pressure',
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
