import 'dart:io';

import 'package:flutter/material.dart';
import 'package:simple_dropdown_search/Builder/conditional_builder.dart';
import 'package:simple_dropdown_search/Model/search_model.dart';

import '../../Options/sheet_options.dart';
import '../Handler/sheet_handler.dart';

class SheetBuilder extends StatelessWidget {
  final Widget? child;
  final SheetOptions options;
  const SheetBuilder({
    Key? key,
    this.child,
    this.options = kSheetOptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: options.handlerStyle == SheetHandlerStyle.floating,
      onBuild: Column(
        children: [
          const SheetFloatingHandler(),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                /// outer padding
                child: Container(
                  decoration: kSheetInnerDecoration,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // draw sheet content here
                      child ?? const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      onFallback: Container(
        decoration: kSheetInnerDecoration,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
             Container(
               margin: (options.onFooterPressed != null) ? const EdgeInsets.only(bottom: kSheetFooterHeight +5) : EdgeInsets.zero,
               child:  Column(
                 mainAxisSize: MainAxisSize.max,
                 children: [
                   // draw sheet handler here
                   Builder(builder: (context) {
                     switch (options.handlerStyle) {
                       case SheetHandlerStyle.floating:
                         return const SizedBox.shrink();
                       case SheetHandlerStyle.normal:
                         return options.showCloseButton
                             ? const SizedBox.shrink()
                             : const SheetPersistenceHandler();
                       case SheetHandlerStyle.none:
                         return options.showCloseButton
                             ? const SizedBox.shrink()
                             : const SizedBox.shrink();
                       default:
                         return const SizedBox.shrink();
                     }
                   }),
                   // draw sheet header here
                   SheetHeader(options: options),
                   // draw sheet content here
                   child ?? const SizedBox.shrink(),
                   // draw sheet footer here
                 ],
               ),
             ),
              if (options.onFooterPressed != null)
                SheetFooter(options: options),
            ],
          ),
        ),
      ),
    );
  }
}

class SheetHeader extends StatelessWidget {
  final SheetOptions options;

  final VoidCallback? onClose;

  const SheetHeader({Key? key, required this.options, this.onClose})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: options.hideSheetHeader ||
          options.title == "" ||
          options.title == null,
      onBuild: const SizedBox.shrink(),
      onFallback: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (options.onHeaderActionTap != null)
              TextButton(
                onPressed: () {
                  options.onHeaderActionTap!();
                },
                child: Text(
                  options.headerActionText ?? kSheetSaveText,
                  style: kSheetHeaderActionStyle,
                ),
              ),
            Text(
              options.title ?? '',
              style: kSheetTitleStyle,
            ),
            if (options.showCloseButton)
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: onClose ?? () => Navigator.of(context).pop(),
              ),
          ],
        ),
      ),
    );
  }
}

class SheetFooter extends StatelessWidget {
  final SheetOptions options;

  const SheetFooter({Key? key, required this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: options.onFooterPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, kSheetFooterHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
        child: Text(
          options.footerText ?? kSheetSaveText,
        ),

    );
  }
}

class AdaptiveLocalSearch extends StatelessWidget {
  final List<SearchModel> items;
  final TextEditingController controller;
  final Function(List<SearchModel>) onSearchResult;

  const AdaptiveLocalSearch(
      {Key? key,
      required this.items,
      required this.controller,
      required this.onSearchResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: Platform.isIOS,
      onBuild: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ),
      onFallback: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search anything here ...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                controller.clear();
                onSearchResult(items);
              },
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          onSubmitted: (_) => _search(controller.text, items, onSearchResult),
          onChanged: (_) => _search(controller.text, items, onSearchResult),
          controller: controller,
        ),
      ),
    );
  }
}

void _search(String value, List<SearchModel> items,
    Function(List<SearchModel>) onSearchResult) {
  print("1.value ${value} ");
  // items.clear();
  print("2.items ${items} ");

  /// search with title only
  List<SearchModel> searchResult = items.where((element) {
    return element.title.contains(value.toUpperCase()) ||
        element.title.toUpperCase().contains(value.toLowerCase());
  }).toList();
  print("3.items ${searchResult} ");
  onSearchResult(searchResult);
}

const BoxDecoration kSheetInnerDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  ),
);

