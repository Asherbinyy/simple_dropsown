import 'package:flutter/material.dart';

enum SheetHandlerStyle {
  floating,
  normal,
  none,
}

class SheetOptions {
  final bool showCloseButton;
  final bool showSheetHandler;
  final bool hideSheetHeader;
  final SheetHandlerStyle handlerStyle;

  // title
  final String? title;
  final TextStyle? titleStyle;

  // headerActionText
  final String? headerActionText;
  final TextStyle? headerActionStyle;
  final VoidCallback? onHeaderActionTap;

  // footer
  final String? footerText;
  final VoidCallback? onFooterPressed;

  const SheetOptions({
    this.showCloseButton = true,
    this.showSheetHandler = true,
    this.hideSheetHeader = false,
    this.handlerStyle = SheetHandlerStyle.normal,
    this.title,
    this.titleStyle,
    this.headerActionText,
    this.headerActionStyle,
    this.onHeaderActionTap,
    this.footerText,
    this.onFooterPressed,

  });
// final String ?title;
// final String? message;
// final String? cancelText;
// final String? confirmText;
// final Color? backgroundColor;
// final Color? textColor;
// final Color? cancelColor;
// final Color? confirmColor;
// final Color? cancelTextColor;
// final Color? confirmTextColor;
// final double? borderRadius;
// final double? elevation;
// final double? width;
// final double? height;
// final double? blur;
// final double? opacity;
// final double? padding;
// final double? margin;
// final double? radius;
// final double? animateDuration;
// final bool? dismissible;
// final bool? enableDrag;
// final bool? isDismissible;
// final bool? isScrollControlled;
// final bool? useRootNavigator;
// final bool? useSafeArea;
// final bool? enableSafeArea;
// final bool? enableBackButton;

}

const SheetOptions kSheetOptions = SheetOptions(
  showCloseButton: true,
  showSheetHandler: true,
  handlerStyle: SheetHandlerStyle.floating,
);
const TextStyle kSheetTitleStyle = TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);
const TextStyle kSheetHeaderActionStyle = TextStyle(
  color: Colors.blueAccent,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);
const String kSheetSaveText = 'Save';
const double kSheetFooterHeight = 50;

