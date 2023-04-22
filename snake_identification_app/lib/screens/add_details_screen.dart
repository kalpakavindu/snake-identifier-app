import 'package:flutter/material.dart';
import 'package:snake_identification_app/color_scheme.dart';
import 'package:snake_identification_app/screens/details_screen.dart';
import '../widgets/reusable_text_button.dart';
import '../widgets/reusable_dropdown_field.dart';
import '../models/snake_details_model.dart';

class AddDetailsScreen extends StatefulWidget {
  const AddDetailsScreen({super.key});

  @override
  State<AddDetailsScreen> createState() => _AddDetailsScreenState();
}

class _AddDetailsScreenState extends State<AddDetailsScreen> {
  final _lengthList = [
    {"name": "Short", "value": "short"},
    {"name": "Long", "value": "long"},
  ];
  final _colorList = [
    {"name": "Red", "value": "red"},
    {"name": "Green", "value": "green"},
    {"name": "Black", "value": "black"},
    {"name": "White", "value": "white"},
    {"name": "Yellow", "value": "yellow"},
    {"name": "Brown", "value": "brown"},
  ];
  final _locationList = [
    {"name": "Floor", "value": "floor"},
    {"name": "Mud", "value": "mud"},
    {"name": "Tree", "value": "tree"},
    {"name": "Other", "value": "other"},
  ];
  final _scalesPatternList = [
    {"name": "SPattern1", "value": "sp1"},
    {"name": "SPattern2", "value": "sp2"},
    {"name": "SPattern3", "value": "sp3"},
  ];
  final _headPatternList = [
    {"name": "HPattern1", "value": "hp1"},
    {"name": "HPattern2", "value": "hp2"},
    {"name": "HPattern3", "value": "hp3"},
  ];
  final _timeList = [
    {"name": "Morning", "value": "morning"},
    {"name": "Afternoon", "value": "afternoon"},
    {"name": "Evening", "value": "evening"},
    {"name": "Night", "value": "night"},
  ];

  String? _selectedLengthValue;
  String? _selectedColorValue;
  String? _selectedLocationValue;
  String? _selectedScalesPatternValue;
  String? _selectedHeadPatternValue;
  String? _selectedTimeValue;

  SnakeDetails snakeDetails = SnakeDetails();

  final _formKey = GlobalKey<FormState>();

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      snakeDetails.name = "Russell's viper";
      snakeDetails.description =
          "Russell's viper (Daboia russelii) is a venomous snake found in Asia. The species is named for Patrick Russell, a Scottish herpetologist who first described many of India's snakes. In Bengali, this snake is called Chandroborha since it carries lenticular or more precisely lunar marks all over its body.";

      snakeDetails.image = null;

      setState(() {
        _selectedColorValue = null;
        _selectedHeadPatternValue = null;
        _selectedLengthValue = null;
        _selectedLocationValue = null;
        _selectedScalesPatternValue = null;
        _selectedTimeValue = null;
      });

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return DetailsScreen(details: snakeDetails);
      }));
    }
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
                items: _lengthList,
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
                items: _colorList,
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
                items: _locationList,
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
                items: _scalesPatternList,
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
                items: _headPatternList,
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
                items: _timeList,
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
