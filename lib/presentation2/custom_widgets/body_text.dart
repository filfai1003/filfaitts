import 'package:flutter/material.dart';

class BodyText extends StatelessWidget {
  final String text;
  final int maxLines;
  final TextAlign? textAlign;

  const BodyText(
    this.text, {
    Key? key,
    this.maxLines = 10,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyLarge;
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: TextOverflow.visible,
      style: style,
    );
  }
}

