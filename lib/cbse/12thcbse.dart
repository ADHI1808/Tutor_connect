import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../display/display.dart';
import '../Upload/upload.dart';
import '../study.dart';

class TwelfthCBSEPage extends StatefulWidget {
  @override
  _TwelfthCBSEPageState createState() => _TwelfthCBSEPageState();
}

class _TwelfthCBSEPageState extends State<TwelfthCBSEPage> {
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

  // Use the refactored function with the path '12th CBSE'
  Future<void> _fetchFiles() async {
    final files = await fetchFilesFromStorage('12th CBSE');  // Pass the path as an argument
    setState(() {
      _files = files;
    });
  }

  // Use the refactored delete function with the path '12th CBSE'
  Future<void> _deleteFile(String fileName) async {
    await deleteFile('12th CBSE', fileName);  // Pass the path and the file name
    _fetchFiles(); // Refresh the file list after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('12th CBSE Materials'),centerTitle: true,
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
        onDelete: _deleteFile,
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
              onPressed: () => uploadFile(context, '12th CBSE'), // Path is '12th CBSE'
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