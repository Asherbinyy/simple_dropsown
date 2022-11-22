import 'package:flutter/material.dart';

class RadioSingleChoice extends StatefulWidget {

  bool isSelected;
  final Function(bool?) onChanged;

  RadioSingleChoice(
      {Key? key,

        required this.isSelected,
        required this.onChanged,})
      : super(key: key);

  @override
  State<RadioSingleChoice> createState() => _RadioSingleChoiceState();
}
class _RadioSingleChoiceState extends State<RadioSingleChoice> {
  bool? _groupValue = true;

  @override
  Widget build(BuildContext context) {
    return Radio<bool>(
      value: widget.isSelected,
      groupValue: _groupValue,
      onChanged: (value) {
        setState(() {
          _groupValue = value;
          widget.onChanged(value);
          print("old value ${widget.isSelected} new value $value");
        });
      },
    );
  }
}