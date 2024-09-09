import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:file_picker/file_picker.dart';

import '../study.dart';

class sixthCBSEPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('6th CBSE Materials'),
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
        automaticallyImplyLeading: false, // No back button
      ),
      body: Center(
        child: Text(
          '6th CBSE Materials will be displayed here.',
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
              onPressed: () => _uploadFile(context),
              child: Icon(Icons.add),
              backgroundColor: Colors.blueAccent,
            );
          }
        }
        return SizedBox.shrink();
      },
    );
  }

  Future<void> _uploadFile(BuildContext context) async {
    // Pick files
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();

      for (File file in files) {
        // Show confirmation dialog
        bool? confirmUpload = await _showConfirmationDialog(context, file);

        if (confirmUpload == true) {
          try {
            // Upload to Firebase Storage
            String fileName = file.uri.pathSegments.last;
            Reference storageReference = FirebaseStorage.instance
                .ref()
                .child('uploads/12thCBSE/$fileName');
            UploadTask uploadTask = storageReference.putFile(file);

            TaskSnapshot snapshot = await uploadTask;

            // Get download URL
            String downloadURL = await snapshot.ref.getDownloadURL();

            // Store metadata in Realtime Database
            DatabaseReference databaseReference =
            FirebaseDatabase.instance.ref().child('files').push();
            await databaseReference.set({
              'fileName': fileName,
              'fileURL': downloadURL,
              'uploadedBy': FirebaseAuth.instance.currentUser?.email,
              'timestamp': DateTime.now().toIso8601String(),
              'section': '12th CBSE',
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

  Future<bool?> _showConfirmationDialog(BuildContext context, File file) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Upload'),
        content: Text('Do you want to upload "${file.uri.pathSegments.last}" to 12th CBSE?'),
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
