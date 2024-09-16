import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'SigninSignup/signup.dart';
import 'package:demodev/cbse/10thcbse.dart';
import 'package:demodev/cbse/11thcbse.dart';
import 'package:demodev/cbse/12thcbse.dart';
import 'package:demodev/cbse/5thcbse.dart';
import 'package:demodev/cbse/6thcbse.dart';
import 'package:demodev/cbse/7thcbse.dart';
import 'package:demodev/cbse/8thcbse.dart';
import 'package:demodev/cbse/9thcbse.dart';
import 'package:demodev/matric/10thmatric.dart';
import 'package:demodev/matric/11thmatric.dart';
import 'package:demodev/matric/5thmatric.dart';
import 'package:demodev/matric/6thmatric.dart';
import 'package:demodev/matric/7thmatric.dart';
import 'package:demodev/matric/8thmatric.dart';
import 'package:demodev/matric/9thmatric.dart';
import 'package:demodev/matric/12thmatric.dart';

class StudyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Materials'),centerTitle: true,
        backgroundColor: Colors.blueAccent,
        automaticallyImplyLeading: false, // Removes the back button
      ),
      body: ContainerGrid(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class ContainerGrid extends StatelessWidget {
  final List<Map<String, String>> items = [
    {"name": "12th CBSE", "image": "assets/12thcbse.png"},
    {"name": "11th CBSE", "image": "assets/11thcbse.png"},
    {"name": "10th CBSE", "image": "assets/10thcbse.png"},
    {"name": "9th CBSE", "image": "assets/9thcbse.png"},
    {"name": "8th CBSE", "image": "assets/8thcbse.png"},
    {"name": "7th CBSE", "image": "assets/7thcbse.png"},
    {"name": "6th CBSE", "image": "assets/6thcbse.png"},
    {"name": "5th CBSE", "image": "assets/5thcbse.png"},
    {"name": "12th MATRIC", "image": "assets/12thmatric.png"},
    {"name": "11th MATRIC", "image": "assets/11thmatric.png"},
    {"name": "10th MATRIC", "image": "assets/10thmatric.png"},
    {"name": "9th MATRIC", "image": "assets/9thmatric.png"},
    {"name": "8th MATRIC", "image": "assets/8thmatric.png"},
    {"name": "7th MATRIC", "image": "assets/7thmatric.png"},
    {"name": "6th MATRIC", "image": "assets/6thmatric.png"},
    {"name": "5th MATRIC", "image": "assets/5thmatric.png"},
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
            if (item["name"] == "12th CBSE") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TwelfthCBSEPage()));
            } else if (item["name"] == "11th CBSE") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => EleventhCBSEPage()));
            } else if (item["name"] == "10th CBSE") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TenthCBSEPage()));
            } else if (item["name"] == "9th CBSE") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NinethCBSEPage()));
            } else if (item["name"] == "8th CBSE") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => EightthCBSEPage()));
            } else if (item["name"] == "7th CBSE") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SeventhCBSEPage()));
            } else if (item["name"] == "6th CBSE") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SixthCBSEPage()));
            } else if (item["name"] == "5th CBSE") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FifthCBSEPage()));
            } else if (item["name"] == "12th MATRIC") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TwelfthmatricPage()));
            } else if (item["name"] == "11th MATRIC") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => EleventhMATRICPage()));
            } else if (item["name"] == "10th MATRIC") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TenthMATRICPage()));
            } else if (item["name"] == "9th MATRIC") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NinethMATRICPage()));
            } else if (item["name"] == "8th MATRIC") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => EightthMATRICPage()));
            } else if (item["name"] == "7th MATRIC") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SeventhMATRICPage()));
            } else if (item["name"] == "6th MATRIC") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SixthMATRICPage()));
            } else if (item["name"] == "5th MATRIC") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FifthMAtricPage()));
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
              child: Image.asset(
                item["image"]!, // Load image from assets
                height: 140, // Set image height
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
