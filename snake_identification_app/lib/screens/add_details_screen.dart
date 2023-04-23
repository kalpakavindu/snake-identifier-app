import 'dart:io';
import 'package:flutter/material.dart';
import 'package:snake_identification_app/color_scheme.dart';
import 'package:snake_identification_app/screens/details_screen.dart';
import '../widgets/reusable_text_button.dart';
import '../widgets/reusable_dropdown_field.dart';
import '../models/snake_details_model.dart';
import '../constants.dart';

class AddDetailsScreen extends StatefulWidget {
  const AddDetailsScreen({super.key});

  @override
  State<AddDetailsScreen> createState() => _AddDetailsScreenState();
}

class _AddDetailsScreenState extends State<AddDetailsScreen> {
  String? _selectedLengthValue;
  String? _selectedColorValue;
  String? _selectedLocationValue;
  String? _selectedScalesPatternValue;
  String? _selectedHeadPatternValue;
  String? _selectedTimeValue;

  SnakeDetails snakeDetails = SnakeDetails();

  final _formKey = GlobalKey<FormState>();

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      snakeDetails.length = _selectedLengthValue!;
      snakeDetails.color = _selectedColorValue!;
      snakeDetails.location = _selectedLocationValue!;
      snakeDetails.headPattern = _selectedHeadPatternValue ?? 'none';
      snakeDetails.scalesPattern = _selectedScalesPatternValue ?? 'none';
      snakeDetails.time = _selectedTimeValue ?? 'none';
      snakeDetails.image = null;

      setState(() {
        _selectedColorValue = null;
        _selectedHeadPatternValue = null;
        _selectedLengthValue = null;
        _selectedLocationValue = null;
        _selectedScalesPatternValue = null;
        _selectedTimeValue = null;
      });

      final resData = await snakeDetails.predictedData();

      _navigateDetailsScreen(resData, null);
    }
  }

  void _navigateDetailsScreen(Map<String, dynamic> details, File? image) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DetailsScreen(
        details: details,
        image: image,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(top: 20.0),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ReusableDropdownField(
                onUpdate: (val) {
                  setState(() {
                    _selectedLengthValue = val as String;
                  });
                },
                value: _selectedLengthValue,
                items: snakeLengthOptions,
                label: 'Length of the snake',
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'This field is required!';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              ReusableDropdownField(
                onUpdate: (val) {
                  setState(() {
                    _selectedColorValue = val as String;
                  });
                },
                value: _selectedColorValue,
                items: snakeColorOptions,
                label: 'Color of the snake',
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'This field is required!';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              ReusableDropdownField(
                onUpdate: (val) {
                  setState(() {
                    _selectedLocationValue = val as String;
                  });
                },
                value: _selectedLocationValue,
                items: snakeLocationOptions,
                label: 'Where did you see it ?',
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'This field is required!';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              ReusableDropdownField(
                onUpdate: (val) {
                  setState(() {
                    _selectedScalesPatternValue = val as String;
                  });
                },
                value: _selectedScalesPatternValue,
                items: snakeScalesPatternOptions,
                label: 'Scales pattern of the snake',
              ),
              const SizedBox(
                height: 20.0,
              ),
              ReusableDropdownField(
                onUpdate: (val) {
                  setState(() {
                    _selectedHeadPatternValue = val as String;
                  });
                },
                value: _selectedHeadPatternValue,
                items: snakeHeadPatternOptions,
                label: 'Head Pattern of the snake',
              ),
              const SizedBox(
                height: 20.0,
              ),
              ReusableDropdownField(
                onUpdate: (val) {
                  setState(() {
                    _selectedTimeValue = val as String;
                  });
                },
                value: _selectedTimeValue,
                items: snakeTimeOptions,
                label: 'At what time did you see it?',
              ),
              const SizedBox(
                height: 30.0,
              ),
              ReusableTextButton(
                backgroundColor: lightColorScheme.primary,
                textColor: lightColorScheme.onPrimary,
                onTap: _handleSubmit,
                text: 'Next',
              )
            ],
          ),
        ),
      ),
    );
  }
}
