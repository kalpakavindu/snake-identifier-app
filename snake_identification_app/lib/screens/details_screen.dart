import 'dart:io';

import 'package:flutter/material.dart';
import '../color_scheme.dart';
import '../widgets/reusable_data_box.dart';

class DetailsScreen extends StatefulWidget {
  final Map<String, dynamic> details;
  final File? image;

  const DetailsScreen({
    super.key,
    required this.details,
    this.image,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColorScheme.background,
        elevation: 0,
        title: const Text('Snake Details'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: lightColorScheme.background,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: lightColorScheme.surfaceVariant,
                ),
                child: widget.image != null
                    ? Image.file(widget.image as File)
                    : Text(
                        'No image specified',
                        style: TextStyle(
                          color: lightColorScheme.onSurfaceVariant,
                        ),
                      ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              ReusableDataBox(
                text: widget.details['body']['name'],
                backgroundColor: lightColorScheme.onSecondary,
                textStyle: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              ReusableDataBox(
                  text: widget.details['body']['desc'],
                  backgroundColor: lightColorScheme.onSecondary,
                  textStyle: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
