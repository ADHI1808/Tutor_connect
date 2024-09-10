import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:file_picker/file_picker.dart';
import '../study.dart';// Import the StudyPage file

class EleventhMATRICPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('11th MATRIC Materials'),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StudyPage()),
            );
          },
        ),
      ),
      body: Center(
        child: Text(
          '11th MATRIC Materials will be displayed here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data;
          if (user?.email == 'indrasenthil@gmail.com') {
            return FloatingActionButton(
              onPressed: () => _uploadFile(context, '11th MATRIC'),
              child: Icon(Icons.add),
              backgroundColor: Colors.blueAccent,
            );
          }
        }
        return SizedBox.shrink();
      },
    );
  }

  Future<void> _uploadFile(BuildContext context, String section) async {
    // Pick files
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();

      for (File file in files) {
        // Show confirmation dialog
        bool? confirmUpload = await _showConfirmationDialog(context, file, section);

        if (confirmUpload == true) {
          try {
            // Upload to Firebase Storage
            String fileName = file.uri.pathSegments.last;
            Reference storageReference = FirebaseStorage.instance
                .ref()
                .child('$section/$fileName'); // Use section
            UploadTask uploadTask = storageReference.putFile(file);

            TaskSnapshot snapshot = await uploadTask;

            // Get download URL
            String downloadURL = await snapshot.ref.getDownloadURL();

            // Store metadata in Realtime Database
            DatabaseReference databaseReference =
            FirebaseDatabase.instance.ref().child(section).push(); // Use section
            await databaseReference.set({
              'fileName': fileName,
              'fileURL': downloadURL,
              'uploadedBy': FirebaseAuth.instance.currentUser?.email,
              'timestamp': DateTime.now().toIso8601String(),
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('File uploaded successfully!')),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to upload file: $e')),
            );
          }
        }
      }
    }
  }

  Future<bool?> _showConfirmationDialog(BuildContext context, File file, String section) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Upload'),
        content: Text('Do you want to upload "${file.uri.pathSegments.last}" to $section?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // User chose not to upload
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // User confirmed upload
            },
            child: Text('Upload'),
          ),
        ],
      ),
    );
  }
}
