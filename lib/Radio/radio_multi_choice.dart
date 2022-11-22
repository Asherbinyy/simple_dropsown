


import 'package:flutter/material.dart';

class RadioMultiChoice extends StatefulWidget {

  bool isSelected;
  final Function(bool?) onChanged;

  RadioMultiChoice({Key? key,required  this.isSelected, required this.onChanged, }) : super(key: key);

  @override
  State<RadioMultiChoice> createState() => _RadioMultiChoiceState();
}
class _RadioMultiChoiceState extends State<RadioMultiChoice> {
  @override
  Widget build(BuildContext context) {
    return CheckboxTheme(
      data: CheckboxThemeData(
        side: const BorderSide(color: Colors.grey),
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        fillColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
      ),
      child: Checkbox(
        value: widget.isSelected,
        onChanged:widget.onChanged,
      ),
    );
  }
}

