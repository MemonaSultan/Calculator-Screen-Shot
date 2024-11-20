import 'package:flutter/material.dart';
class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('weatherapp'),
         backgroundColor: Colors.red,
        actions:<Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => print('Clicked'),
          )
        ],
      ),
     );

  }
}
