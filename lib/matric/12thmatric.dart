import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Upload/upload.dart';
import '../display/display.dart';
import '../study.dart';

class TwelfthmatricPage extends StatefulWidget {
  @override
  _TwelfthmatricPageState createState() => _TwelfthmatricPageState();
}

class _TwelfthmatricPageState extends State<TwelfthmatricPage> {
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

  // Fetch files for '12th MATRIC'
  Future<void> _fetchFiles() async {
    final files = await fetchFilesFromStorage('12th MATRIC'); // Fetch files from '12th MATRIC' path
    setState(() {
      _files = files;
    });
  }

  // Delete files for '12th MATRIC'
  Future<void> _deleteFile(String fileName) async {
    await deleteFile('12th MATRIC', fileName); // Delete file from '12th MATRIC' path
    _fetchFiles(); // Refresh the list after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('12th MATRIC Materials'),centerTitle: true,
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
              onPressed: () => uploadFile(context, '12th MATRIC'), // Upload to '12th MATRIC'
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
