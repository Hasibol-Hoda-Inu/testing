import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? location;
  String? temperature;
  String? weatherDescription;
  String? weatherImage;
  bool isLoading = false;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=Dinajpur&appid=6a0ad78a64ef7a8c8082e3e4525bffde'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final main = data['main'];
        final weather = data['weather'][0];

        setState(() {
          location = data['name'];
          temperature = (main['temp'] - 273.15).toStringAsFixed(1);
          weatherDescription = weather['description'];
          weatherImage = weather['icon'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple[200]!, Colors.purple[400]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                CircularProgressIndicator()
              else if (hasError)
                Text(
                  'Error fetching weather data.',
                  style: Theme.of(context).textTheme.headline6,
                )
              else if (location != null &&
                    temperature != null &&
                    weatherDescription != null &&
                    weatherImage != null)
                  Column(
                    children: [
                      Text(
                        location!,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(height: 16),
                      Image.network(
                        'https://openweathermap.org/img/w/$weatherImage.png',
                        width: 64,
                        height: 64,
                      ),
                      SizedBox(height: 16),
                      Text(
                        '$temperature°C',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(height: 8),
                      Text(
                        weatherDescription!,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
