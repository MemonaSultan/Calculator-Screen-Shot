import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // To keep track of the current tab index

  // List of pages corresponding to each tab
  final List<Widget> _pages = [
    HomeScreen(),
    TestsScreen(),
    AcademicsScreen(),
    BookmarksScreen(),
    ProfileScreen(),
  ];

  // Change the index when a tab is tapped
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Display the current screen based on index
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 5,
        onTap: _onTabTapped, // Handle tab changes
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Tests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Academics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Home screen with Subject Cards (existing code for Home tab)
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Profile Section with gradient background
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/profile_picture.jpg'), // Replace with your image
              ),
              SizedBox(height: 10),
              Text(
                'Memona Sultan',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        // Subjects Grid with new background and padding
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[200], // Light background for contrast
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                SubjectCard(
                  subject: 'Science',
                  videos: 25,
                  questions: 345,
                  concepts: 322,
                  icon: Icons.science,
                  cardColor: Colors.tealAccent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubjectDetailPage(subject: 'Science'),
                      ),
                    );
                  },
                ),
                SubjectCard(
                  subject: 'Mathematics',
                  videos: 25,
                  questions: 345,
                  concepts: 322,
                  icon: Icons.calculate,
                  cardColor: Colors.lightBlueAccent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubjectDetailPage(subject: 'Mathematics'),
                      ),
                    );
                  },
                ),
                SubjectCard(
                  subject: 'English',
                  videos: 25,
                  questions: 345,
                  concepts: 322,
                  icon: Icons.language,
                  cardColor: Colors.orangeAccent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubjectDetailPage(subject: 'English'),
                      ),
                    );
                  },
                ),
                SubjectCard(
                  subject: 'Logical Reasoning',
                  videos: 25,
                  questions: 345,
                  concepts: 322,
                  icon: Icons.psychology,
                  cardColor: Colors.purpleAccent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubjectDetailPage(subject: 'Logical Reasoning'),
                      ),
                    );
                  },
                ),
                SubjectCard(
                  subject: 'History',
                  videos: 25,
                  questions: 345,
                  concepts: 322,
                  icon: Icons.history_edu,
                  cardColor: Colors.pinkAccent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubjectDetailPage(subject: 'History'),
                      ),
                    );
                  },
                ),
                SubjectCard(
                  subject: 'Civics',
                  videos: 25,
                  questions: 345,
                  concepts: 322,
                  icon: Icons.gavel,
                  cardColor: Colors.greenAccent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubjectDetailPage(subject: 'Civics'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// SubjectCard widget updated to handle taps
class SubjectCard extends StatelessWidget {
  final String subject;
  final int videos;
  final int questions;
  final int concepts;
  final IconData icon;
  final Color cardColor;
  final VoidCallback onTap; // Add a callback for when the card is tapped

  const SubjectCard({
    Key? key,
    required this.subject,
    required this.videos,
    required this.questions,
    required this.concepts,
    required this.icon,
    required this.cardColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Trigger the navigation when the card is tapped
      child: Card(
        elevation: 5,
        shadowColor: Colors.black45,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: cardColor.withOpacity(0.3), // Soft color effect
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.deepPurple),
              SizedBox(height: 10),
              Text(
                subject,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              SizedBox(height: 10),
              Text(
                '$videos Videos',
                style: TextStyle(fontSize: 14, color: Colors.grey[800]),
              ),
              Text(
                '$questions Questions',
                style: TextStyle(fontSize: 14, color: Colors.grey[800]),
              ),
              Text(
                '$concepts Concepts',
                style: TextStyle(fontSize: 14, color: Colors.grey[800]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Subject detail page to display after clicking on a subject card
class SubjectDetailPage extends StatelessWidget {
  final String subject;

  const SubjectDetailPage({Key? key, required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$subject Details'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text(
          'Welcome to the $subject page!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// New screens for each tab (same as before)
class TestsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Tests Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class AcademicsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Academics Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class BookmarksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Bookmarks Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
