import 'package:flutter/material.dart';
import '../color_scheme.dart';

class ReusableDropdownField extends StatefulWidget {
  final void Function(Object?) onUpdate;
  final String? value;
  final List<Map<String, dynamic>> items;
  final String label;
  final String? Function(Object?)? validator;

  const ReusableDropdownField({
    super.key,
    required this.onUpdate,
    this.value,
    this.validator,
    required this.items,
    required this.label,
  });

  @override
  State<ReusableDropdownField> createState() => _ReusableDropdownFieldState();
}

class _ReusableDropdownFieldState extends State<ReusableDropdownField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: DropdownButtonFormField(
        validator: widget.validator,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        value: widget.value,
        hint: Text(
          widget.label,
          style: TextStyle(color: lightColorScheme.outline),
        ),
        onChanged: (val) {
          widget.onUpdate(val);
        },
        items: widget.items.map(
          (item) {
            return DropdownMenuItem(
              value: item['value']!,
              child: item['child']!,
            );
          },
        ).toList(),
      ),
    );
  }
}
