import 'package:flutter/material.dart';
import 'package:simple_dropdown_search/Builder/conditional_builder.dart';
import 'package:simple_dropdown_search/Radio/radio_multi_choice.dart';
import 'package:simple_dropdown_search/Radio/radio_single_choice.dart';

enum CardChoiceType { single, multiple }

enum CardChoiceStyle { hasBorder, hasShadow, none }

class CardChoice extends StatefulWidget {
  final String title;
  final String subtitle;
  final String image;
  bool isSelected;
  final Function(bool) onSelect;
  final CardOptions options;

  CardChoice({
    Key? key,
    this.isSelected = false,
    required this.title,
    required this.onSelect,
    this.subtitle = '',
    this.image = '',
    required this.options,
  }) : super(key: key);

  @override
  State<CardChoice> createState() => _CardChoiceState();
}

class _CardChoiceState extends State<CardChoice> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isSelected = !widget.isSelected;
        });
        widget.onSelect(widget.isSelected);
      },
      child: _BuildCardChoiceStyle(
        options: widget.options,
        isSelected: widget.isSelected,
        child: Row(
          children: [
            if (widget.image != '')
              Image.network(
                widget.image,
                width: 50,
                height: 50,
              ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: const TextStyle(fontSize: 16)),
                if (widget.subtitle != '') ...[
                  const SizedBox(height: 5),
                  Text(widget.subtitle,
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ],
            ),
            const Spacer(),
            ConditionalBuilder(
              condition: widget.options.cardStyle == CardChoiceType.single,
              onBuild: RadioSingleChoice(
                isSelected: widget.isSelected,
                onChanged: (value) {
                  setState(() {
                    widget.isSelected = value!;
                  });
                  widget.onSelect(widget.isSelected);
                },
              ),
              onFallback: RadioMultiChoice(
                  isSelected: widget.isSelected,
                  onChanged: (value) {
                    setState(() {
                      widget.isSelected = value ?? false;
                    });
                    widget.onSelect(widget.isSelected);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

/// build Card Choice Style
class _BuildCardChoiceStyle extends StatelessWidget {
  final CardOptions options;
  final Widget child;
  final bool isSelected;

  const _BuildCardChoiceStyle({
    Key? key,
    required this.options,
    required this.child,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: options.margin,
      padding: options.padding ,
      child: Builder(builder: (context) {
        switch (options.cardStyle) {
          case CardChoiceStyle.hasBorder:
            return Container(
              margin: options.margin ,
              decoration: BoxDecoration(
                border: options.hideBorders ? null:Border.all(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.grey.withOpacity(0.2),
                ) ,
                borderRadius: BorderRadius.circular(8),
              ),
              child: child,
            );
          case CardChoiceStyle.hasShadow:
            return Container(
              margin: options.margin   ,
               decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: child,
            );
          case CardChoiceStyle.none:
            return child;
        }
      }),
    );
  }
}

class CardOptions {
  final CardChoiceType cardType;
  final CardChoiceStyle cardStyle;
  final EdgeInsets padding;
  final EdgeInsets margin;

  // border
  final bool hideBorders;
  final bool hasDivider;

  CardOptions({
    required this.cardType,
    this.cardStyle = CardChoiceStyle.hasBorder,
    this.padding  = EdgeInsets.zero,
    this.margin  = const EdgeInsets.only(bottom: 5),
    this.hideBorders = false,
    this.hasDivider = false,
  });

  CardOptions copyWith({
    CardChoiceType? cardType,
    CardChoiceStyle? cardStyle,
    EdgeInsets? cardPadding,
    EdgeInsets? cardMargin,
    bool? hideBorders,
    bool? hasDivider,
  }) {
    return CardOptions(
      cardType: cardType ?? this.cardType,
      cardStyle: cardStyle ?? this.cardStyle,
      padding: cardPadding ?? padding,
      margin: cardMargin ?? margin,
      hideBorders: hideBorders ?? this.hideBorders,
      hasDivider: hasDivider ?? this.hasDivider,
    );
  }
}
