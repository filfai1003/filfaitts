import 'package:flutter/material.dart';

class CaptionText extends StatelessWidget {
  final String text;
  final int maxLines;

  const CaptionText(this.text, {Key? key, this.maxLines = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium;
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: style,
    );
  }
}

