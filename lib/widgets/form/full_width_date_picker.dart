// widgets/form/full_width_date_picker.dart
import 'package:flutter/material.dart';
import '../../utils/date_utils.dart' as DateUtils;

class FullWidthDatePicker extends StatelessWidget {
  final String label;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onChanged;

  const FullWidthDatePicker({
    super.key,
    required this.label,
    required this.selectedDate,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
        fillColor: Colors.white,
        filled: true,
        suffixIcon: Icon(Icons.calendar_today, size: 18),
      ),
      readOnly: true,
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(1900),
          lastDate: DateTime.now().add(Duration(days: 365)),
        );
        if (date != null) onChanged(date);
      },
      controller: TextEditingController(
        text: DateUtils.DateUtils.format(selectedDate),
      )..selection = TextSelection.fromPosition(
          TextPosition(offset: DateUtils.DateUtils.format(selectedDate).length),
        ),
    );
  }
}
