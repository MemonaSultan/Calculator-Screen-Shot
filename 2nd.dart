import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        backgroundColor: Colors.purple[700],
        elevation: 0,
        leading: Icon(Icons.menu),
        actions: [Icon(Icons.settings)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'), // User's profile image
            ),
            SizedBox(height: 16),
            Text(
              'Hi, Precious',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.purple[900],
              ),
            ),
            Text(
              'Joined Aug, 2022',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'Quote of the day',
                    style: TextStyle(fontSize: 18, color: Colors.purple[900]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'The time we spend awake is precious, but so is the time we spend asleep.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '- Lebron James',
                    style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            _buildZenMasterSection(),
            SizedBox(height: 24),
            _buildRectangularIconsSection(context), // Pass context here
            Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomIcon(context, Icons.home, 'Home', ProfileScreen()),
              _buildBottomIcon(context, Icons.search, 'Search', SearchScreen()), // Navigate to SearchScreen
              _buildBottomIcon(context, Icons.remove_red_eye, 'View', ProfileScreen()),
            ],
          ),
        ),
      ),
    );
  }

  // Rectangular icons for Stats, History, Edit, Share My Profile
  Widget _buildRectangularIconsSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildRectangularIcon(context, Icons.bar_chart, 'Stats', StatsScreen()),
        _buildRectangularIcon(context, Icons.history, 'History', HistoryScreen()),
        _buildRectangularIcon(context, Icons.edit, 'Edit', EditProfileScreen()),
        _buildRectangularIcon(context, Icons.share, 'Share Profile', ShareProfileScreen()),
      ],
    );
  }

  Widget _buildRectangularIcon(BuildContext context, IconData icon, String label, Widget nextPage) {
    return GestureDetector(
      onTap: () {
        // Navigate to the next page when tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.purple[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 32),
            SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  // Bottom navigation icons for Home, Search, View
  Widget _buildBottomIcon(BuildContext context, IconData icon, String label, Widget nextPage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.purple[700]),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: Colors.purple[700], fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildZenMasterSection() {
    return Column(
      children: [
        Text(
          'Zen Master',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.purple[900],
          ),
        ),
        SizedBox(height: 8),
        LinearProgressIndicator(
          value: 220 / 300, // progress value
          color: Colors.purple[700],
          backgroundColor: Colors.purple[100],
          minHeight: 10,
        ),
        SizedBox(height: 8),
        Text(
          'Level 4',
          style: TextStyle(fontSize: 16, color: Colors.purple[900]),
        ),
      ],
    );
  }
}

// New pages for each feature
class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stats')),
      body: Center(child: Text('Stats Page')),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('History')),
      body: Center(child: Text('History Page')),
    );
  }
}

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile')),
      body: Center(child: Text('Edit Profile Page')),
    );
  }
}

class ShareProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Share Profile')),
      body: Center(child: Text('Share Profile Page')),
    );
  }
}

// Search screen with search functionality
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  List<String> searchResults = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                setState(() {
                  query = text;
                });
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: searchResults
                    .where((result) => result.toLowerCase().contains(query.toLowerCase()))
                    .map((result) => ListTile(
                  title: Text(result),
                ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
