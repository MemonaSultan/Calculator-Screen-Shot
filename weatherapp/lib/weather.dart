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
        title: Text(
          'Weather App',
            style:TextStyle(
              color: Colors.white,
          ),
        ),


        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(
                Icons.menu,
              color: Colors.white,
            ),
            onPressed: () => print('Clicked'),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage('assets/images/umbrella.png'),
              height: 1200.0,
              width: 1530.0,
              fit: BoxFit.fill,
            ),
          ),
          // Corrected Container widget
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0.0),
            child: Text('Vehari',
                style: TextStyle(color: Colors.white,
                    fontSize: 24,fontStyle:  FontStyle.italic)),

          ),
          Center(
            child: Image(
              image: AssetImage('assets/images/raindrops.png'),
              width: 200.0,
              height: 200.0,

            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30.0,140.0,0.0,0.0),
            alignment: Alignment.center,
            child: Text(
              '50.32F',
                  style:TextStyle(color:Colors.white,
                  fontSize: 24,fontStyle: FontStyle.italic,fontFamily: 'Arial',fontWeight: FontWeight.bold)
            ),
          )

        ],
      ),
    );
  }
}
