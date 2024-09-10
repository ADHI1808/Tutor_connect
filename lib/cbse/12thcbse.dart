import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../Upload&Display/upload.dart';
import '../study.dart';

class TwelfthCBSEPage extends StatefulWidget {
  @override
  _TwelfthCBSEPageState createState() => _TwelfthCBSEPageState();
}

class _TwelfthCBSEPageState extends State<TwelfthCBSEPage> {
  List<Map<String, String>> _files = []; // To store file names and URLs

  @override
  void initState() {
    super.initState();
    _fetchFilesFromStorage();
  }

  Future<void> _fetchFilesFromStorage() async {
    try {
      final ListResult result = await FirebaseStorage.instance.ref('12th CBSE').listAll();
      final List<Map<String, String>> files = [];

      for (var ref in result.items) {
        final String url = await ref.getDownloadURL();
        final String name = ref.name; // Get the file name
        files.add({'name': name, 'url': url});
      }

      setState(() {
        _files = files;
      });
    } catch (e) {
      print('Error fetching files: $e');
    }
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
      body: _buildFileList(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  // Build the list of files fetched from Firebase Storage
  Widget _buildFileList() {
    if (_files.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemCount: _files.length,
        itemBuilder: (context, index) {
          final file = _files[index];
          final fileName = file['name'];

          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Text(
                fileName ?? 'Unknown File',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                fileName?.endsWith('.pdf') ?? false
                    ? 'PDF Document'
                    : 'Non-PDF File',
                style: TextStyle(color: Colors.grey),
              ),
              trailing: fileName?.endsWith('.pdf') ?? false
                  ? Icon(Icons.picture_as_pdf, color: Colors.red)
                  : null,
              onTap: fileName?.endsWith('.pdf') ?? false
                  ? () {
                // Launch external PDF viewer apps

              }
                  : null,
            ),
          );
        },
      );
    }
  }

  // Function to open the PDF in external apps


  // Show FloatingActionButton for admin to upload new files
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
