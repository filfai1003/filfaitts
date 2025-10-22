import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final int maxLines;

  const TitleText(
    this.text, {
    Key? key,
    this.textAlign,
    this.maxLines = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.titleLarge;
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: style,
    );
  }
}

