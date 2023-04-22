import 'dart:io';

import 'package:flutter/material.dart';
import '../color_scheme.dart';
import '../models/snake_details_model.dart';
import '../widgets/reusable_data_box.dart';

class DetailsScreen extends StatefulWidget {
  final SnakeDetails details;

  const DetailsScreen({
    super.key,
    required this.details,
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
                child: widget.details.image != null
                    ? Image.file(widget.details.image as File)
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
                text: widget.details.name as String,
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
                  text: widget.details.description as String,
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
