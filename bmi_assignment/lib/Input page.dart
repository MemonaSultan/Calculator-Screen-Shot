import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BMICalculator(),
  ));
}

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [

                Expanded(
                  child: RepeatContainercode(),
                ),

                Expanded(
                  child: RepeatContainercode(),
                ),
              ],
            ),
          ),
                Expanded(
                  child: RepeatContainercode(),

                  ),


                Expanded(
                  child: RepeatContainercode(),
                ),
              ],
            ),
        //  ),
       // ],
     // ),
    );
  }
}

class RepeatContainercode extends StatelessWidget {
  const RepeatContainercode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(25),
      ),
      // child: Center(
      //   child: Text(
      //     'Height',
      //     style: TextStyle(color: Colors.white, fontSize: 18),
      //   ),
      // ),
    );
  }
}


