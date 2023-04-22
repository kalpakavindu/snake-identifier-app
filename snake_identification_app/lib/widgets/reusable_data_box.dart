import 'package:flutter/material.dart';

class ReusableDataBox extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final TextStyle textStyle;

  const ReusableDataBox({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 10.0,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 20.0,
          ),
        ],
      ),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
