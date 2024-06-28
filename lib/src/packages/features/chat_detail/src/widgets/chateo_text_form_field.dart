
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/ui/ui.dart';
import '../emojis/emojis.dart';


class ChateoTextFormField extends StatefulWidget {
  const ChateoTextFormField({
    super.key,
    required this.onSend,
  });

  final Function(String msg, bool isAudio, bool isImage, bool isFile) onSend;

  @override
  State<ChateoTextFormField> createState() => _ChateoTextFormFieldState();
}

class _ChateoTextFormFieldState extends State<ChateoTextFormField> {

  final emojis = emojisChateo;
  late final TextEditingController _msgController;
  bool isTextEmpty = true;
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  String? _audioFilePath;

  @override
  void initState() {
    super.initState();
    _msgController = TextEditingController();
    _msgController.addListener(() {
      setState(() {
        isTextEmpty = _msgController.text.trim().isEmpty;
      });
    });
    _initializeRecorder();
  }

 
  Future<void> _initializeRecorder() async {
    try {
      await _recorder.openRecorder();
      await _requestMicrophonePermission();
    } catch (e) {
      print("Error initializing recorder: $e");
    }
  }

  Future<void> _requestMicrophonePermission() async {
    if (await Permission.microphone.status != PermissionStatus.granted) {
      await Permission.microphone.request();
    }
  }

  @override
  void dispose() {
    _msgController.dispose();
    _recorder.closeRecorder();
    super.dispose();
  }

   Future<void> _startRecording() async {
    if (_recorder.isRecording) return;
    if (!await Permission.microphone.isGranted) {
      await Permission.microphone.request();
    }
    Directory tempDir = await getTemporaryDirectory();
    String path = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.aac';
    await _recorder.startRecorder(
      toFile: path,
    );
    setState(() {
      _isRecording = true;
      _audioFilePath = path;
    });
  }

    Future<void> _stopRecording() async {
    if (!_recorder.isRecording) return;
    await _recorder.stopRecorder();
    setState(() {
      _isRecording = false;
    });
    if (_audioFilePath != null) {
      String audioUrl = await _uploadAudioFile(File(_audioFilePath!));
      widget.onSend(audioUrl, true, false, false); // Enviar mensaje de audio
    }
  }

  Future<String> _uploadAudioFile(File audioFile) async {
    String fileName = '${DateTime.now().millisecondsSinceEpoch}.aac';
    Reference storageRef = FirebaseStorage.instance.ref().child('audio/$fileName');
    UploadTask uploadTask = storageRef.putFile(audioFile);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }


  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String imageUrl = await _uploadImageFile(File(pickedFile.path));
      widget.onSend(imageUrl, false, true, false); // Enviar mensaje de imagen
    }
  }

  Future<String> _uploadImageFile(File imageFile) async {
    String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    Reference storageRef = FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = storageRef.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

   Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      String fileUrl = await _uploadFile(File(result.files.single.path!));
      widget.onSend(fileUrl, false, false, true); // Enviar archivo adjunto
    }
  }

  Future<String> _uploadFile(File file) async {
    String fileName = '${DateTime.now().millisecondsSinceEpoch}.${file.path.split('.').last}';
    Reference storageRef = FirebaseStorage.instance.ref().child('files/$fileName');
    UploadTask uploadTask = storageRef.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: ColoredBox(
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: ChateoDimens.dimen_12),
            child: Row(
              children: [
              IconButton(onPressed: _pickFile, icon: Icon(Icons.attach_file_rounded)),
               
                Flexible(
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    controller: _msgController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: ChateoDimens.dimen_8,
                        horizontal: ChateoDimens.dimen_16,
                      ),
                      hintText: 'Escribe un mensaje',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: ChateoColors.darkGrey,
                      ),
                      fillColor: ChateoColors.greyForm,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ChateoColors.greyForm,
                        ),
                        borderRadius: BorderRadius.circular(
                          ChateoDimens.dimen_20,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ChateoColors.greyForm,
                        ),
                        borderRadius: BorderRadius.circular(
                          ChateoDimens.dimen_20,
                        ),
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.emoji_emotions_outlined, color: ChateoColors.black,),
                            onPressed: () {
                              _showEmojiPicker(context);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.photo_camera_rounded, color: ChateoColors.black,),
                            onPressed: _pickImage,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: ChateoDimens.dimen_12,
                ),
                FloatingActionButton.small(
                  onPressed: isTextEmpty
                      ? () {
                          _isRecording ? _stopRecording() : _startRecording();
                        }
                      : () {
                          final msg = _msgController.text.trim();
                          if (msg.isNotEmpty) {
                            widget.onSend(msg, false, false, false); // Enviar mensaje de texto
                            _msgController.clear();
                          }
                        },
                  shape: const CircleBorder(),
                  backgroundColor: ChateoColors.primaryChat,
                  elevation: 0,
                  child: Icon(
                    isTextEmpty ? (_isRecording ? Icons.stop : Icons.mic) : Icons.send,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



   void _showEmojiPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Container(
          height: 250,
          padding: EdgeInsets.all(10),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: emojis.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _msgController.text += emojis[index];
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text(
                    emojis[index],
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

}

// class ChateoTextFormField extends StatefulWidget {
//   const ChateoTextFormField({
//     super.key,
//     required this.onSend,
//   });

//   final Function(String msg) onSend;

//   @override
//   State<ChateoTextFormField> createState() => _ChateoTextFormFieldState();
// }

// class _ChateoTextFormFieldState extends State<ChateoTextFormField> {
//   late final TextEditingController _msgController;
//   bool isTextEmpty = true;

//   @override
//   void initState() {
//     _msgController = TextEditingController();
//     _msgController.addListener(() {
//       setState(() {
//         isTextEmpty = _msgController.text.trim().isEmpty;
//       });
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _msgController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: SafeArea(
//         child: ColoredBox(
//           color: Color.fromARGB(255, 255, 255, 255),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: ChateoDimens.dimen_12),
//             child: Row(
//               children: [
//                 IconButton(onPressed: (){}, icon: Icon(Icons.attach_file_rounded)),
//                 Flexible(
//                   child: TextFormField(
//                     textCapitalization: TextCapitalization.sentences,
//                     textInputAction: TextInputAction.newline,
//                     keyboardType: TextInputType.multiline,
//                     minLines: 1,
//                     maxLines: 5,
//                     controller: _msgController,
//                     decoration: InputDecoration(
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: ChateoDimens.dimen_8,
//                         horizontal: ChateoDimens.dimen_16,
//                       ),
//                       hintText: 'Escribe un mensaje',
//                       hintStyle: TextStyle(
//                         fontSize: 12,
//                         color: ChateoColors.darkGrey,
//                       ),
//                       fillColor: ChateoColors.greyForm,
//                       filled: true,
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: ChateoColors.greyForm,
//                         ),
//                         borderRadius: BorderRadius.circular(
//                           ChateoDimens.dimen_20,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: ChateoColors.greyForm,
//                         ),
//                         borderRadius: BorderRadius.circular(
//                           ChateoDimens.dimen_20,
//                         ),
//                       ),
//                       suffixIcon: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.emoji_emotions_outlined, color: ChateoColors.black,),
//                             onPressed: () {
//                               // Lógica para seleccionar emoticonos
//                             },
//                           ),

//                           IconButton(
//                             icon: Icon(Icons.photo_camera_rounded, color: ChateoColors.black,),
//                             onPressed: () {
//                               // Lógica para seleccionar emoticonos
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: ChateoDimens.dimen_12,
//                 ),
//                 FloatingActionButton.small(
//                   onPressed: isTextEmpty
//                       ? () {
//                           // Lógica para grabar audio
//                         }
//                       : () {
//                           final msg = _msgController.text.trim();
//                           if (msg.isNotEmpty) {
//                             widget.onSend(msg);
//                             _msgController.clear();
//                           }
//                         },
//                   shape: const CircleBorder(),
//                   backgroundColor: ChateoColors.primaryChat,
//                   elevation: 0,
//                   child: Icon(
//                     isTextEmpty ? Icons.mic : Icons.send,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
