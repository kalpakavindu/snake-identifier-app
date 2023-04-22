import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snake_identification_app/color_scheme.dart';
import '../widgets/reusable_text_button.dart';

class SelectPhotoOptionsScreen extends StatelessWidget {
  final Function(ImageSource source) onTap;

  const SelectPhotoOptionsScreen({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -35,
            child: Container(
              width: 50,
              height: 6,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.5),
                color: lightColorScheme.background,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(children: [
            ReusableTextButton(
              onTap: () => onTap(ImageSource.gallery),
              text: 'Browse Gallery',
              backgroundColor: lightColorScheme.primaryContainer,
              textColor: lightColorScheme.onPrimaryContainer,
            ),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text(
                'OR',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ReusableTextButton(
              onTap: () => onTap(ImageSource.camera),
              text: 'Open Camera',
              backgroundColor: lightColorScheme.primary,
              textColor: lightColorScheme.onPrimary,
            )
          ])
        ],
      ),
    );
  }
}
