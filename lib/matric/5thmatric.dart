import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Upload/upload.dart';
import '../display/display.dart';
import '../study.dart';

class FifthMAtricPage extends StatefulWidget {
  @override
  _FifthMAtricPageState createState() => _FifthMAtricPageState();
}

class _FifthMAtricPageState extends State<FifthMAtricPage> {
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

  // Fetch files for '5th MATRIC'
  Future<void> _fetchFiles() async {
    final files = await fetchFilesFromStorage('5th MATRIC'); // Fetch files from '5th MATRIC' path
    setState(() {
      _files = files;
    });
  }

  // Delete files for '5th MATRIC'
  Future<void> _deleteFile(String fileName) async {
    await deleteFile('5th MATRIC', fileName); // Delete file from '5th MATRIC' path
    _fetchFiles(); // Refresh the list after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('5th MATRIC Materials'),centerTitle: true,
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
              onPressed: () => uploadFile(context, '5th MATRIC'), // Upload to '5th MATRIC'
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
