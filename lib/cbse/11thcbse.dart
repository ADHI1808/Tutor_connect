import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Upload/upload.dart';
import '../display/display.dart';
import '../study.dart';

class EleventhCBSEPage extends StatefulWidget {
  @override
  _EleventhCBSEPageState createState() => _EleventhCBSEPageState();
}

class _EleventhCBSEPageState extends State<EleventhCBSEPage> {
  List<Map<String, String>> _files = [];
  User? _currentUser;


  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
    _fetchFiles();
  }

  Future<void> _fetchCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      _currentUser = user;
    });
  }

  // Use the refactored fetchFilesFromStorage for '11th CBSE'
  Future<void> _fetchFiles() async {
    final files = await fetchFilesFromStorage('11th CBSE'); // Pass the folder name
    setState(() {
      _files = files;
    });
  }

  // Use the refactored deleteFile for '11th CBSE'
  Future<void> _deleteFile(String fileName) async {
    await deleteFile('11th CBSE', fileName); // Pass the folder name
    _fetchFiles(); // Refresh the list after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('11th CBSE Materials'),centerTitle: true,
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
      body: buildFileList(
        context: context,
        files: _files,
        currentUser: _currentUser,
        onDelete: _deleteFile, // Pass delete callback
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
              onPressed: () => uploadFile(context, '11th CBSE'), // Path for '11th CBSE'
              child: Icon(Icons.add),
              backgroundColor: Colors.blueAccent,
            );
          }
        }
        return SizedBox.shrink();
      },
    );
  }
}