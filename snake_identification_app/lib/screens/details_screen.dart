import 'dart:io';
import 'package:flutter/material.dart';
import '../models/snake_details_model.dart';
import '../color_scheme.dart';
import '../widgets/reusable_data_box.dart';

class DetailsScreen extends StatefulWidget {
  final Map<String, String>? details;
  final File? image;
  final String? fileName;

  const DetailsScreen({
    super.key,
    this.details,
    this.image,
    this.fileName,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  SnakeDetails snakeDetails = SnakeDetails();

  Future<Map<String, dynamic>> _fetchData() async {
    if (widget.details != null) {
      snakeDetails.color = widget.details!['color'];
      snakeDetails.headPattern = widget.details!['head_pattern'];
      snakeDetails.length = widget.details!['length'];
      snakeDetails.location = widget.details!['location'];
      snakeDetails.scalesPattern = widget.details!['scales_pattern'];
      snakeDetails.time = widget.details!['time'];
      snakeDetails.image = null;
    }

    if (widget.image != null) {
      snakeDetails.fileName = widget.fileName;
      snakeDetails.image = widget.image;
    }

    return snakeDetails.predictedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorScheme.background,
      appBar: AppBar(
        backgroundColor: lightColorScheme.background,
        elevation: 0,
        title: const Text('Snake Details'),
      ),
      body: FutureBuilder(
        future: _fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Details(data: snapshot.data!, image: widget.image);
          } else if (snapshot.hasError) {
            return const Text('An unexpected error occurred');
          } else {
            return const PreLoader();
          }
        },
      ),
    );
  }
}

class PreLoader extends StatelessWidget {
  const PreLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(vertical: 100.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          const SizedBox(
            width: 100.0,
            height: 100.0,
            child: CircularProgressIndicator(),
          ),
          Text(
            'Processing...',
            style: TextStyle(
              color: lightColorScheme.outline,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}

class Details extends StatelessWidget {
  final File? image;
  final Map<String, dynamic> data;

  const Details({
    super.key,
    this.image,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        child: Column(
          children: [
            image != null
                ? Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 30.0),
                    width: MediaQuery.of(context).size.width,
                    height: 200.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: lightColorScheme.surfaceVariant,
                    ),
                    child: Image.file(image as File),
                  )
                : const SizedBox(),
            ReusableDataBox(
              text: data['body']['name'],
              backgroundColor: lightColorScheme.onSecondary,
              textStyle: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            image != null
                ? Container(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Row(
                      children: [
                        IntrinsicHeight(
                          child: ReusableDataBox(
                            title: 'Image Similarity',
                            width:
                                MediaQuery.of(context).size.width / 2.0 - 25.0,
                            text: "${data['body']['image_similarity']}%",
                            backgroundColor: lightColorScheme.onSecondary,
                            textStyle: const TextStyle(
                              fontSize: 60.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        IntrinsicHeight(
                          child: ReusableDataBox(
                            text: data['body']['venomous_status'],
                            title: 'Venomous Status',
                            width:
                                MediaQuery.of(context).size.width / 2.0 - 25.0,
                            backgroundColor: lightColorScheme.onSecondary,
                            textStyle: const TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            ReusableDataBox(
              addSeeMore: image == null ? false : true,
              text: data['body']['desc'],
              backgroundColor: lightColorScheme.onSecondary,
              textStyle: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
