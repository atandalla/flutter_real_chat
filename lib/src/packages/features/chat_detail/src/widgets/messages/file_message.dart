

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_chat/src/packages/core/ui/ui.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class FileMessageWidget extends StatelessWidget {
  const FileMessageWidget({
    Key? key,
    required this.fileUrl,
    required this.date,
    required this.mySelf,
    required this.name,
    required this.photoUrl
  }) : super(key: key);

  final String fileUrl;
  final DateTime date;
  final bool mySelf;
  final String name;
  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final formattedDate = DateFormat.jm().format(date);
  
    final fileName = _extractFileName(fileUrl);
    final fileExtension = _extractFileExtension(fileName);
    final fileSize = 'Desconocido'; // Tamaño del archivo, no disponible desde URL

    print(fileUrl);
    return Row(
      mainAxisAlignment: mySelf ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!mySelf)
          Padding(
            padding: const EdgeInsets.only(right: ChateoDimens.dimen_20),
            child: ChateoAvatar(
              name: name,
              photoUrl: photoUrl,
            ),
          ),
        Column(
          crossAxisAlignment: mySelf ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _shareFile(context),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                decoration: BoxDecoration(
                  color: mySelf ? ChateoColors.primaryChat : Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                
                  children: [
                    _buildFilePreview(fileExtension),
                    
                    Text(
                      fileName,
                      style: textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: mySelf ? Colors.white : Colors.black,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                     mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          formattedDate.toLowerCase(),
                          style: textTheme.labelSmall?.copyWith(
                            color: mySelf ? Colors.white70 : Colors.black54,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }


  String _extractFileName(String url) {
    final uri = Uri.parse(url);
    final lastSegment = uri.pathSegments.last;
    return Uri.decodeComponent(lastSegment).split('/').last;
  }
  
  String _extractFileExtension(String fileName) {
    return fileName.split('.').last;
  }

  Widget _buildFilePreview(String fileExtension) {
    if (fileExtension == 'pdf') {
      return Container(
        height: 50,
        width: 50,
        color: Colors.white,
        child: Center(
          child: Icon(
            Icons.picture_as_pdf,
            color: Colors.red,
          ),
        ),
      );
    } else {
      return Icon(Icons.insert_drive_file, color: Colors.white);
    }
  }

Future<void> _shareFile(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {

        final response = await http.get(Uri.parse(fileUrl));
        final directory = await getExternalStorageDirectory();
        final fileName = _extractFileName(fileUrl);
        final file = File('${directory!.path}/$fileName');
        await file.writeAsBytes(response.bodyBytes);

        XFile xFile = XFile(file.path);
        Share.shareXFiles([xFile], text: 'Check out this file: $fileName');

    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Error al compartir el archivo')),
      );
    }
  }

  
}
