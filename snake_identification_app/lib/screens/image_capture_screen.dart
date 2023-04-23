import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

import '../color_scheme.dart';
import '../widgets/reusable_text_button.dart';
import './select_photo_options_screen.dart';
import './details_screen.dart';

class ImageCaptureScreen extends StatefulWidget {
  const ImageCaptureScreen({super.key});

  @override
  State<ImageCaptureScreen> createState() => _ImageCaptureScreenState();
}

class _ImageCaptureScreenState extends State<ImageCaptureScreen> {
  var logger = Logger();
  File? _imageFile;
  UploadTask? _uploadTask;

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
      var uuid = const Uuid();
      final String ext = extension(_imageFile!.path);
      String fileName = '${uuid.v4()}$ext';
      // create the reference
      Reference imageRef =
          FirebaseStorage.instance.ref().child('input').child('/$fileName');

      setState(() {
        _uploadTask = imageRef.putFile(_imageFile!);
      });

      await _uploadTask!.whenComplete(() {
        final File image = _imageFile!;

        setState(() {
          _imageFile = null;
          _uploadTask = null;
        });

        Navigator.push(
          this.context,
          MaterialPageRoute(
            builder: (context) {
              return DetailsScreen(
                image: image,
                fileName: fileName,
              );
            },
          ),
        );
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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              width: 300.0,
              height: 200.0,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: lightColorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: _imageFile == null
                    ? Text(
                        'No image selected',
                        style: TextStyle(
                          color: lightColorScheme.onSurfaceVariant,
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
          _imageFile == null
              ? ReusableTextButton(
                  textColor: lightColorScheme.onPrimary,
                  backgroundColor: lightColorScheme.primary,
                  text: 'Add an Image',
                  onTap: () => _showSelectPhotoOptions(context),
                )
              : Column(
                  children: [
                    _uploadTask == null
                        ? ReusableTextButton(
                            textColor: lightColorScheme.onPrimaryContainer,
                            text: 'Not this image',
                            onTap: _rejectImage,
                            backgroundColor: lightColorScheme.primaryContainer,
                          )
                        : const Center(
                            child: Text(
                              'Uploading...',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    _uploadTask == null
                        ? ReusableTextButton(
                            textColor: lightColorScheme.onPrimary,
                            backgroundColor: lightColorScheme.primary,
                            text: 'Next',
                            onTap: _uploadImage,
                          )
                        : buildProgress(),
                  ],
                ),
        ],
      ),
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.blue.shade100,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
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
