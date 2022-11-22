import 'package:flutter/material.dart';
import 'package:simple_dropdown_search/Cards/card_choice.dart';
import 'package:simple_dropdown_search/Model/search_model.dart';
import 'package:simple_dropdown_search/Model/sheet_model.dart';
import 'package:simple_dropdown_search/Radio/radio_multi_choice.dart';
import 'package:simple_dropdown_search/Radio/radio_single_choice.dart';
import 'package:simple_dropdown_search/Sheet/Implementation/Body/sheet_body.dart';


class SheetSelection extends StatefulWidget {
  final CardChoiceType cardChoiceType;
  final List<SheetModel>? data;
  final bool includeSearch;
  final TextEditingController? searchController;
  List<int>? selectedIDs;
  final CardOptions ?  options;
  final Function(List<SheetModel> selectedItems)? onSave;
  SheetSelection({
    Key? key,
    required this.data,
    this.selectedIDs,
    this.onSave,
    this.cardChoiceType = CardChoiceType.single,
    required this.includeSearch,
    this.searchController,
    this.options,
  }) : super(key: key);

  @override
  State<SheetSelection> createState() => _SheetSelectionState();
}

class _SheetSelectionState extends State<SheetSelection> {
  ScrollController  ? _scrollController  ;
  List<SheetModel>? sheetData = [];

  @override
  void initState() {
    _scrollController = ScrollController();
    sheetData = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          if (widget.includeSearch)
            AdaptiveLocalSearch(
              controller: widget.searchController!,
              items: (widget.data ?? [])
                  .map((e) =>
                      SearchModel(id: e.id, title: e.title, value: e.subtitle))
                  .toList(),
              onSearchResult: (newList) {
                // print("SEARCHING $newList");
                setState(() {
                  sheetData = newList
                      .map((e) => SheetModel(
                          id: e.id, title: e.title, subtitle: e.subtitle))
                      .toList();
                });
              },
            ),
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              child: ListView.separated(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                itemCount: (sheetData ?? []).length,
                itemBuilder: (context, index) {
                  final element = sheetData?[index];
                  return CardChoice(
                    title: element?.title ?? "",
                    subtitle: element?.subtitle ?? "",
                    image: element?.image ?? "",
                    options: widget.options ?? CardOptions(
                        cardType: widget.cardChoiceType,
                      cardStyle: CardChoiceStyle.hasBorder,
                    ),
                    isSelected:
                        widget.selectedIDs?.contains(element?.id) ?? false,
                    onSelect: (_) {
                      if (widget.cardChoiceType == CardChoiceType.single) {
                        widget.selectedIDs?.clear();
                      }
                      setState(() {
                        if (widget.selectedIDs?.contains(element?.id) ??
                            false) {
                          widget.selectedIDs?.remove(element?.id);
                        } else {
                          widget.selectedIDs?.add(element?.id ?? 0);
                        }
                      });
                      widget.onSave?.call((sheetData ?? [])
                          .where((element) =>
                              (widget.selectedIDs ?? []).contains(element.id))
                          .toList());
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return (widget.options?.hasDivider??false) ?const Divider() :const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}




