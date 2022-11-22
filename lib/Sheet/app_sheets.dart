import 'package:flutter/material.dart';
import 'package:simple_dropdown_search/Cards/card_choice.dart';
import 'package:simple_dropdown_search/Model/sheet_model.dart';
import 'package:simple_dropdown_search/Presentation/Home/presentation/pages/home_screen.dart';
import 'package:simple_dropdown_search/Sheet/DefaultSheets/search_sheet.dart';
import 'package:simple_dropdown_search/Sheet/Implementation/Body/sheet_body.dart';
import 'package:simple_dropdown_search/Sheet/Options/sheet_options.dart';

class AppSheets {
  static void showBottomSheet({
    required BuildContext context,
    required Widget child,
    SheetOptions? options,

  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SheetBuilder(
        options: options ?? kSheetOptions,
        child: child,
      ),
      backgroundColor: Colors.transparent,
      shape: kSheetShape,
      elevation: 0,

    );
  }


  static void showApiSheet({
    required BuildContext context,
    CardChoiceType cardChoiceType = CardChoiceType.single,
    required List<SheetModel>? fetchedItems,
    required List<int>? selectedIDs,
    bool includeSearch = false,
    TextEditingController? searchController,
    SheetOptions? options,
    Function(List<SheetModel> selectedItems)? onSave,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SheetBuilder(
        options: SheetOptions(
          title: options?.title ?? 'Search',
          headerActionText: "Save",
          onHeaderActionTap: () {
            final selectedItems = fetchedItems!
                .where((element) => selectedIDs!.contains(element.id))
                .toList();
            onSave!(selectedItems);
            Navigator.pop(context);
            print("SAVED FROM SHEET API $selectedIDs}");
            print("SAVED FROM SHEET API $selectedItems}");
          },
        ),
        child: SheetSelection(
          data: fetchedItems,
          selectedIDs: selectedIDs,
          cardChoiceType: cardChoiceType,
          onSave: onSave,
          includeSearch: includeSearch,
          searchController: searchController,
        ),
      ),
      backgroundColor: Colors.transparent,
      shape: kSheetShape,
      elevation: 0,
    );
  }
}
