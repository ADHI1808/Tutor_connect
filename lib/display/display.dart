import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'pdfviewer.dart';

// Function to fetch files from any specified storage path
Future<List<Map<String, String>>> fetchFilesFromStorage(String storagePath) async {
  try {
    final ListResult result = await FirebaseStorage.instance.ref(storagePath).listAll();
    final List<Map<String, String>> files = [];

    for (var ref in result.items) {
      final String url = await ref.getDownloadURL();
      final String name = ref.name;
      files.add({'name': name, 'url': url});
    }

    return files;
  } catch (e) {
    print('Error fetching files: $e');
    return [];
  }
}

// Function to delete a file from any specified storage path
Future<void> deleteFile(String storagePath, String fileName) async {
  try {
    await FirebaseStorage.instance.ref('$storagePath/$fileName').delete();
  } catch (e) {
    print('Error deleting file: $e');
  }
}

// Widget to build the list of files from any specified storage path
Widget buildFileList({
  required BuildContext context,
  required List<Map<String, String>> files,
  required User? currentUser,
  required Function(String) onDelete,
}) {
  if (files.isEmpty) {
    return Center(child: CircularProgressIndicator());
  } else {
    return ListView.builder(
      itemCount: files.length,
      itemBuilder: (context, index) {
        final file = files[index];
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (fileName?.endsWith('.pdf') ?? false)
                  Icon(Icons.picture_as_pdf, color: Colors.red)
                else
                  SizedBox.shrink(),
                if (currentUser?.email == 'indrasenthil@gmail.com')
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final confirm = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Delete File'),
                          content: Text('Are you sure you want to delete $fileName?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      );
                      if (confirm == true) {
                        await onDelete(fileName!);
                      }
                    },
                  ),
              ],
            ),
            onTap: fileName?.endsWith('.pdf') ?? false
                ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PDFViewerPage(pdfUrl: file['url']!),
                ),
              );
            }
                : null,
          ),
        );
      },
    );
  }
}
