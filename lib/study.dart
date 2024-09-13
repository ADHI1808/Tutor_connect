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
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'matric/12thmatric.dart'; // Import your TwelfthCBSEPage

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
            }else if (item == "11th CBSE") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EleventhCBSEPage()),
              );
            }else if (item == "10th CBSE") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TenthCBSEPage()),
              );
            }else if (item == "9th CBSE") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NinethCBSEPage()),
              );
            }else if (item == "8th CBSE") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EightthCBSEPage()),
              );
            }else if (item == "7th CBSE") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SeventhCBSEPage()),
              );
            }else if (item == "6th CBSE") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SixthCBSEPage()),
              );
            }else if (item == "5th CBSE") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FifthCBSEPage()),
              );
            }else if (item == "12th MATRIC") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TwelfthmatricPage()),
              );
            }else if (item == "11th MATRIC") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EleventhMATRICPage()),
              );
            }else if (item == "10th MATRIC") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TenthMATRICPage()),
              );
            }else if (item == "9th MATRIC") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NinethMATRICPage()),
              );
            }else if (item == "8th MATRIC") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EightthMATRICPage()),
              );
            }else if (item == "7th MATRIC") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SeventhMATRICPage()),
              );
            }else if (item == "6th MATRIC") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SixthMATRICPage()),
              );
            }else if (item == "5th MATRIC") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FifthMAtricPage()),
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
