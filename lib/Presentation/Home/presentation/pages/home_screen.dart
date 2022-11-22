import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_dropdown_search/Cards/card_choice.dart';
import 'package:simple_dropdown_search/Dialog/dialog_options.dart';
import 'package:simple_dropdown_search/Dialog/dialogs.dart';
import 'package:simple_dropdown_search/Model/sheet_model.dart';
import 'package:simple_dropdown_search/Sheet/app_sheets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Simple Dropdown Search'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '0',
              style: Theme.of(context).textTheme.headline4,
            ),
            FloatingActionButton(
              onPressed: () {
                AppDialogs.showAlertDialog(
                  context,
                  title: 'Test',
                  content: 'Test Content',
                  options: DialogOptions(
                    mainActionText: 'OK',
                    onMainActionPressed: () {
                      print('OK');
                    },
                    secondaryActionText: 'Cancel',
                    onSecondaryActionPressed: () {
                      print('Cancel');
                    },
                  ),
                );
              },
              child: const Icon(Icons.share),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('increment_floatingActionButton'),
        onPressed: () {
          AppSheets.showApiSheet(
            context: context,
            fetchedItems: SheetModel.countryExample,
            selectedIDs: [1],
            cardChoiceType: CardChoiceType.multiple,
            includeSearch: false,
            searchController: TextEditingController(),
            onSave: (selectedItems) {
              if (kDebugMode) {
                print(selectedItems);
              }
            },
          );
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }
}

const kSheetShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  ),
);
