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

  Future<void> _fetchFiles() async {
    final files = await fetchFilesFromStorage();
    setState(() {
      _files = files;
    });
  }

  Future<void> _deleteFile(String fileName) async {
    await deleteFile(fileName);
    _fetchFiles(); // Refresh the file list after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('12th CBSE Materials'),
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
      body: buildFileList(context, _files, _currentUser, _deleteFile),
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
              onPressed: () => uploadFile(context, '12th CBSE'),
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
