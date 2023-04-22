import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import '../widgets/reusable_text_button.dart';
import './select_photo_options_screen.dart';

class ImageCaptureScreen extends StatefulWidget {
  const ImageCaptureScreen({super.key});

  @override
  State<ImageCaptureScreen> createState() => _ImageCaptureScreenState();
}

class _ImageCaptureScreenState extends State<ImageCaptureScreen> {
  var logger = Logger();
  File? _imageFile;
  UploadTask? _uploadTask;
  String? _downloadUrl;

  Future _pickImage(ImageSource source) async {
    try {
      final selected = await ImagePicker().pickImage(source: source);
      if (selected == null) return;
      File? img = File(selected.path);
      setState(() {
        _imageFile = img;
      });
    } on PlatformException catch (e) {
      logger.e(e.message);
      Navigator.of(context as BuildContext).pop();
    }
  }

  void _rejectImage() {
    setState(() {
      _imageFile = null;
    });
  }

  void _uploadImage() async {
    try {
      if (_imageFile == null) return;

      String fileName = basename(_imageFile!.path);
      // create the reference
      Reference imageRef =
          FirebaseStorage.instance.ref().child('images').child('/$fileName');

      setState(() {
        _uploadTask = imageRef.putFile(_imageFile!);
      });

      await _uploadTask!.whenComplete(() => {});
      _downloadUrl = await imageRef.getDownloadURL();
      logger.i('Download URL: $_downloadUrl');

      //TODO: After the image was upload.

      setState(() {
        _uploadTask = null;
      });
    } on PlatformException catch (e) {
      logger.e(e.message);
    }
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            width: 300.0,
            height: 200.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: _imageFile == null
                  ? const Text(
                      'No image selected',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black38,
                      ),
                    )
                  : Image(
                      image: FileImage(_imageFile as File),
                      height: 200.0,
                      width: 300.0,
                      fit: BoxFit.contain,
                    ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 40,
            left: 30.0,
            right: 30.0,
          ),
          child: _imageFile == null
              ? ReusableTextButton(
                  backgroundColor: Colors.black,
                  text: 'Add an Image',
                  onTap: () => _showSelectPhotoOptions(context),
                )
              : Column(
                  children: [
                    _uploadTask == null
                        ? ReusableTextButton(
                            backgroundColor: Colors.black38,
                            text: 'Not this image',
                            onTap: _rejectImage,
                          )
                        : const Center(
                            child: Text('Uploading...'),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    _uploadTask == null
                        ? ReusableTextButton(
                            backgroundColor: Colors.black,
                            text: 'Next',
                            onTap: _uploadImage,
                          )
                        : buildProgress(),
                  ],
                ),
        ),
      ],
    );
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
        stream: _uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;

            return SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey,
                      color: Colors.green),
                  Center(
                      child: Text(
                    '${(100 * progress).roundToDouble()}%',
                    style: const TextStyle(color: Colors.white),
                  )),
                ],
              ),
            );
          } else {
            return const SizedBox(
              height: 50,
            );
          }
        },
      );
}
