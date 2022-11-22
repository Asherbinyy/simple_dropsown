import 'package:flutter/material.dart';

class ConditionalBuilder extends StatelessWidget {
  final bool condition;
  final Widget onBuild;

  final Widget onFallback;

  const ConditionalBuilder(
      {Key? key,
        required this.condition,
        required this.onBuild,
        required this.onFallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return condition ? onBuild : onFallback;
  }
}
