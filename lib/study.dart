import 'package:flutter/material.dart';

class StudyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Materials'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ContainerGrid(),
    );
  }
}

class ContainerGrid extends StatelessWidget {
  final List<String> items = [
    "12th CBSE", "11th CBSE","10th CBSE", "9th CBSE", "8th CBSE", "7th CBSE", "6th CBSE",
    "5th CBSE", "12th MATRIC", "11th MATRIC","10th MATRIC", "9th MATRIC", "8th MATRIC",
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
        return Container(
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
              items[index],
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold, // Bold text
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
