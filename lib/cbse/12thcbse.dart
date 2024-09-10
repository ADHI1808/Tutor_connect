import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart'; // For viewing PDFs
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

  Widget _buildFileList() {
    if (_files.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemCount: _files.length,
        itemBuilder: (context, index) {
          final file = _files[index];
          final fileName = file['name'];
          final fileUrl = file['url'];

          // Only show PDFs in the list
          if (fileName?.endsWith('.pdf') ?? false) {
            return ListTile(
              title: Text(fileName ?? 'Unknown File'),
              trailing: Icon(Icons.picture_as_pdf),
              onTap: () {
                // Open the PDF viewer with the file URL
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfViewerPage(pdfUrl: fileUrl ?? ''),
                  ),
                );
              },
            );
          } else {
            return ListTile(
              title: Text('Non-PDF File'),
            );
          }
        },
      );
    }
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

class PdfViewerPage extends StatelessWidget {
  final String pdfUrl;

  PdfViewerPage({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SfPdfViewer.network(pdfUrl), // Display the PDF using Syncfusion's PDF viewer
    );
  }
}
