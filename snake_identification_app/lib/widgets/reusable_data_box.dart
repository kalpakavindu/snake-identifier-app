import 'package:flutter/material.dart';
import '../color_scheme.dart';

class ReusableDataBox extends StatefulWidget {
  final String text;
  final Color backgroundColor;
  final TextStyle textStyle;
  final double? width;
  final String? title;
  final bool addSeeMore;

  const ReusableDataBox({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textStyle,
    this.width,
    this.title,
    this.addSeeMore = false,
  });

  @override
  State<ReusableDataBox> createState() => _ReusableDataBoxState();
}

class _ReusableDataBoxState extends State<ReusableDataBox> {
  bool _seeingMore = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 10.0,
      ),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: widget.addSeeMore & _seeingMore
          ? TextButton(
              onPressed: () {
                setState(() {
                  _seeingMore = false;
                });
              },
              child: const Text('See more'),
            )
          : Container(
              child: widget.title == null
                  ? Text(
                      widget.text,
                      style: widget.textStyle,
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 60.0,
                          child: Text(
                            widget.text,
                            style: widget.textStyle,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          widget.title!,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            color: lightColorScheme.outlineVariant,
                          ),
                        ),
                      ],
                    ),
            ),
    );
  }
}
