import 'dart:async';
import 'dart:convert';
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

  Future _fetchData() async {
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
    try {
      return await snakeDetails.predictedData();
    } catch (e) {
      return e;
    }
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
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!['status'] != 200) {
              return ErrorOccurred(
                  error:
                      "Request failed with status code ${snapshot.data!['status']}");
            } else {
              return Details(
                  data: jsonDecode(snapshot.data!['body']),
                  image: widget.image);
            }
          } else if (snapshot.hasError) {
            return ErrorOccurred(error: '${snapshot.error}');
          } else {
            return const PreLoader();
          }
        },
      ),
    );
  }
}

class ErrorOccurred extends StatelessWidget {
  final String error;
  const ErrorOccurred({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(vertical: 100.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            error,
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
              text: data['name'],
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
                            text: data['similarity'],
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
                            text: data['status'],
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
              text: data['des'],
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
