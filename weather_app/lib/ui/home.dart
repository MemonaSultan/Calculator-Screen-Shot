import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/constants.dart';
import 'package:weather_app/ui/detail_page.dart';
import 'package:weather_app/widgets/weather_item.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Constants myConstants = Constants();

  // Initialization
  int temperature = 0;
  int maxTemp = 0;
  String weatherStateName = 'Loading..';
  int humidity = 0;
  int windSpeed = 0;

  var currentDate = 'Loading..';
  String imageUrl = '';
  int woeid = 44418; // Default city is London
  String location = 'London'; // Default city

  // Get the cities and selected cities data
  var selectedCities = City.getSelectedCities();
  List<String> cities = [
    'London',
  ]; // List to hold selected cities, default is London

  List consolidatedWeatherList = []; // To hold weather data after API call

  // API URLs
  String searchLocationUrl = 'https://www.metaweather.com/api/location/search/?query='; // To get woeid
  String searchWeatherUrl = 'https://www.metaweather.com/api/location/'; // To get weather details using the woeid

  // Get the Where on Earth ID
  void fetchLocation(String location) async {
    var searchResult = await http.get(Uri.parse(searchLocationUrl + location));
    var result = json.decode(searchResult.body)[0];
    setState(() {
      woeid = result['woeid'];
    });
  }

  void fetchWeatherData() async {
    var weatherResult = await http.get(Uri.parse(searchWeatherUrl + woeid.toString()));
    var result = json.decode(weatherResult.body);
    var consolidatedWeather = result['consolidated_weather'];

    setState(() {
      // Handle the weather data for the next 7 days
      consolidatedWeatherList = consolidatedWeather;

      // Current day's weather data (index 0)
      temperature = consolidatedWeather[0]['the_temp'].round();
      weatherStateName = consolidatedWeather[0]['weather_state_name'];
      humidity = consolidatedWeather[0]['humidity'].round();
      windSpeed = consolidatedWeather[0]['wind_speed'].round();
      maxTemp = consolidatedWeather[0]['max_temp'].round();

      // Date formatting
      var myDate = DateTime.parse(consolidatedWeather[0]['applicable_date']);
      currentDate = DateFormat('EEEE, d MMMM').format(myDate);

      // Set the image URL for the weather state
      imageUrl = weatherStateName.replaceAll(' ', '').toLowerCase();

      consolidatedWeatherList = consolidatedWeather.toSet().toList(); // Remove duplicates from the list
    });
  }

  @override
  void initState() {
    super.initState();
    fetchLocation(cities[0]);
    fetchWeatherData();

    // Extract the selected cities and add to the list
    for (int i = 0; i < selectedCities.length; i++) {
      cities.add(selectedCities[i].city);
    }
  }

  // Create a shader linear gradient
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    // Create a size variable for the media query
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile image
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.asset(
                  'assets/profile.png',
                  width: 40,
                  height: 40,
                ),
              ),
              // Location dropdown
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/pin.png',
                    width: 20,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: location,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: cities.map((String location) {
                          return DropdownMenuItem(
                              value: location, child: Text(location));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            location = newValue!;
                            fetchLocation(location);
                            fetchWeatherData();
                          });
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              location,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
            Text(
              currentDate,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: size.width,
              height: 200,
              decoration: BoxDecoration(
                  color: myConstants.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: myConstants.primaryColor.withOpacity(.5),
                      offset: const Offset(0, 25),
                      blurRadius: 10,
                      spreadRadius: -12,
                    ),
                  ]),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -40,
                    left: 20,
                    child: imageUrl == ''
                        ? const Text('')
                        : Image.asset(
                      'assets/' + imageUrl + '.png',
                      width: 150,
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 20,
                    child: Text(
                      weatherStateName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            temperature.toString(),
                            style: TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = linearGradient,
                            ),
                          ),
                        ),
                        Text(
                          'o',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = linearGradient,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  weatherItem(
                    text: 'Wind Speed',
                    value: windSpeed,
                    unit: 'km/h',
                    imageUrl: 'assets/windspeed.png',
                  ),
                  weatherItem(
                    text: 'Humidity',
                    value: humidity,
                    unit: '',
                    imageUrl: 'assets/humidity.png',
                  ),
                  weatherItem(
                    text: 'Max Temp',
                    value: maxTemp,
                    unit: 'C',
                    imageUrl: 'assets/max-temp.png',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Today',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  'Next 7 Days',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: myConstants.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: consolidatedWeatherList.length,
                itemBuilder: (BuildContext context, int index) {
                  String today = DateTime.now().toString().substring(0, 10);
                  var selectedDay = consolidatedWeatherList[index]['applicable_date'];
                  var futureWeatherName = consolidatedWeatherList[index]['weather_state_name'];
                  var weatherUrl = futureWeatherName.replaceAll(' ', '').toLowerCase();
                  var temperature = consolidatedWeatherList[index]['the_temp'].round();
                  var day = DateFormat('EEEE').format(DateTime.parse(selectedDay));

                  if (selectedDay.compareTo(today) == 0) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              selectedCity: location,
                              consolidatedWeather: consolidatedWeatherList,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 120,
                        decoration: BoxDecoration(
                          color: myConstants.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: myConstants.primaryColor.withOpacity(.5),
                              offset: const Offset(0, 5),
                              blurRadius: 10,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/$weatherUrl.png',
                              width: 40,
                            ),
                            Text(
                              day,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '$temperature°C',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container(); // Return empty if it's not today
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
