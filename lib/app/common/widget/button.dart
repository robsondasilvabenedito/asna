import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.width,
    this.minWidth,
    this.height,
    this.minHeight,
    this.background,
    required this.text,
    this.onTap,
    this.fontSize,
    this.marginTop,
    this.marginBottom,
    this.marginLeft,
    this.marginRight,
  });

  /// Width
  ///
  /// Button width.
  final double? width;

  /// MinWidth
  ///
  /// Button minimum width;
  final double? minWidth;

  /// Height
  ///
  /// Button height.
  final double? height;

  /// MinHeight
  ///
  /// Button minimum height.
  final double? minHeight;

  /// Background
  ///
  /// Button background color.
  final Color? background;

  /// Name
  ///
  /// Button text.
  final String text;

  /// OnTap
  ///
  /// Tap function.
  final void Function()? onTap;

  /// FontSize
  ///
  /// Button font size.
  final double? fontSize;

  /// Top
  ///
  /// Margin top.
  final double? marginTop;

  /// Bottom
  ///
  /// Margin bottom.
  final double? marginBottom;

  /// Left
  ///
  /// Margin left.
  final double? marginLeft;

  /// Right
  ///
  /// Margin right.
  final double? marginRight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      constraints: BoxConstraints(
        minHeight: minHeight ?? 0,
        minWidth: minWidth ?? 0,
      ),
      padding: const EdgeInsets.all(5),
      margin: EdgeInsets.only(
        top: marginTop ?? 0,
        bottom: marginBottom ?? 0,
        left: marginLeft ?? 0,
        right: marginRight ?? 0,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
              color: Color(0xFF666262),
              blurRadius: 2.5,
              offset: Offset(0.0, 0.5))
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: fontSize),
        ),
      ),
    );
  }
}
