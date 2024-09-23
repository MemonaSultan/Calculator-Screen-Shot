
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Icon Container (Top Bar)
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: ClipOval(
                  child: Container(
                    color: Colors.blue,
                    width: 100,
                    height: 100,
                    child: Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Profile Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Memona Sultan',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Punjab, Pakistan',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Fashion enthusiast with a flair for creativity. Passionate about styling outfits that express individuality and exploring the latest trends.',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  // Photography and Fashion Feature Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Photography Feature
                      GestureDetector(
                        onTap: () => _showPhotographyDialog(context),
                        child: Column(
                          children: [
                            Icon(Icons.photo, size: 40, color: Colors.lightBlue),
                            SizedBox(height: 5),
                            Text('Photography'),
                          ],
                        ),
                      ),
                      // Fashion Feature
                      GestureDetector(
                        onTap: () => _showFashionDialog(context),
                        child: Column(
                          children: [
                            Icon(Icons.style, size: 40, color: Colors.pink),
                            SizedBox(height: 5),
                            Text('Fashion'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _showAddDialog(context),
                ),
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () => _showHomeDialog(context),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _showSearchDialog(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Show Photography Dialog with Album Creation
  void _showPhotographyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Photography'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Explore and share your photography skills!'),
              SizedBox(height: 10),
              Text('You can upload your photos, edit them, and create albums.'),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Logic to create a new album
                  Navigator.of(context).pop();
                  _showCreateAlbumDialog(context);
                },
                child: Text('Create Album'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Show Create Album Dialog
  void _showCreateAlbumDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create New Album'),
          content: TextField(
            decoration: InputDecoration(hintText: 'Enter album name'),
          ),
          actions: [
            TextButton(
              child: Text('Create'),
              onPressed: () {
                // Logic to handle album creation
                Navigator.of(context).pop();
                // You could show a success message here
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Show Fashion Dialog
  void _showFashionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Fashion'),
          content: Text('Discover the latest features, trends in fashion, and outfits! Share your favorite looks and get style inspiration.'),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Show Add Feature Dialog
  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add'),
          content: Text('Add new content, outfits, or photos to your profile.'),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Show Home Feature Dialog
  void _showHomeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Home'),
          content: Text('Navigate to the home screen to explore more features and updates.'),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Show Search Feature Dialog
  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Search'),
          content: Text('Search for your favorite items, trends, or users to stay up-to-date and find inspiration.'),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

