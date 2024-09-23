import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header with back button and more options
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back, color: Colors.black),
                  Icon(Icons.more_vert, color: Colors.black),
                ],
              ),
              SizedBox(height: 20),

              // Profile image
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'https://tse4.mm.bing.net/th?id=OIP.uMAMstgi91MhMY8-C00TuAHaEo&pid=Api&P=0&h=220',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),

              // User details section
              Text(
                'Memona Sultan',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, color: Colors.blueGrey, size: 16),
                  SizedBox(width: 4),
                  Text(
                    'Punjab, Pakistan',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 14),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Description and actions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in classical Latin literature.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54),
                ),
              ),

              SizedBox(height: 20),

              // Icons Row for actions
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildActionIcon(Icons.favorite_border, Colors.redAccent),
                  SizedBox(width: 20),
                  _buildActionIcon(Icons.chat_bubble_outline, Colors.blueGrey),
                ],
              ),

              SizedBox(height: 20),

              // Tags section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Chip(
                      label: Text('#photography'),
                      backgroundColor: Colors.lightBlue[100],
                    ),
                    SizedBox(width: 10),
                    Chip(
                      label: Text('#fashion'),
                      backgroundColor: Colors.lightPink[100],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }

  // Custom method to build action icons with rounded shape
  Widget _buildActionIcon(IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200], // Background color for the icon
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      padding: EdgeInsets.all(12), // Padding around the icon
      child: Icon(icon, color: color),
    );
  }
}
