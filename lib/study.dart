import 'package:demodev/standerds/10thcbse.dart';
import 'package:demodev/standerds/11thcbse.dart';
import 'package:demodev/standerds/12thcbse.dart';
import 'package:demodev/standerds/5thcbse.dart';
import 'package:demodev/standerds/6thcbse.dart';
import 'package:demodev/standerds/7thcbse.dart';
import 'package:demodev/standerds/8thcbse.dart';
import 'package:demodev/standerds/9thcbse.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart'; // Import your TwelfthCBSEPage

class StudyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Materials'),
        backgroundColor: Colors.blueAccent,
        automaticallyImplyLeading: false, // Removes the back button
      ),
      body: ContainerGrid(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class ContainerGrid extends StatelessWidget {
  final List<String> items = [
    "12th CBSE", "11th CBSE", "10th CBSE", "9th CBSE", "8th CBSE", "7th CBSE", "6th CBSE",
    "5th CBSE", "12th MATRIC", "11th MATRIC", "10th MATRIC", "9th MATRIC", "8th MATRIC",
    "7th MATRIC", "6th MATRIC", "5th MATRIC"
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 10.0, // Space between columns
        mainAxisSpacing: 10.0, // Space between rows
      ),
      padding: const EdgeInsets.all(16.0), // Padding around the grid
      itemCount: items.length, // Number of containers
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () {
            if (item == "12th CBSE") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TwelfthCBSEPage()),
              );
            }if (item == "11th CBSE") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => elevenththCBSEPage()),
              );
            }if (item == "10th CBSE") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => tenthCBSEPage()),
              );
            }if (item == "9th CBSE") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ninethCBSEPage()),
              );
            }if (item == "8th CBSE") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => eightthCBSEPage()),
              );
            }if (item == "7th CBSE") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => seventhCBSEPage()),
              );
            }if (item == "6th CBSE") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => sixthCBSEPage()),
              );
            }if (item == "5th CBSE") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => fifthCBSEPage()),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue[(index % 9 + 1) * 100], // Color variation
              borderRadius: BorderRadius.circular(12.0), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(0, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Center(
              child: Text(
                item,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold, // Bold text
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home), // Icon for the current page
          label: 'Current Page',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout), // Icon for logout
          label: 'Logout',
        ),
      ],
      onTap: (index) {
        if (index == 1) {
          _showLogoutDialog(context);
        }
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpPage()));

              } catch (e) {
                // Handle sign-out error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to logout: $e'),
                  ),
                );
              }
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
