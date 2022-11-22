import 'package:flutter/material.dart';

class SheetPersistenceHandler extends StatelessWidget {
  const SheetPersistenceHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _sheetHandlerBuilder();
  }
}
class SheetFloatingHandler extends StatelessWidget {
  const SheetFloatingHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      color: Colors.transparent,
      child: const Center(
        child: _sheetHandlerBuilder(),
      ),
    );
  }
}


class _sheetHandlerBuilder extends StatelessWidget {
  const _sheetHandlerBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.symmetric(vertical:8), // 8
      width: 50,
      height: 5,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

