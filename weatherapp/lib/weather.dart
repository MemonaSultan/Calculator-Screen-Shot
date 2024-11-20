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
      body: Stack(
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage("images/umbrella.png"),
              height: 1200.0,
              width: 590.0,
              fit:BoxFit.fill
            ),
          //  child: new Image.asset("images/umbrella.png"),
          )

        ],
      ),
     );

  }
}
