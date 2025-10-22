import 'package:flutter/material.dart';

class ProgressWidget extends StatelessWidget {
  final String currentlyProcessingFile;
  final int currentProgress;

  const ProgressWidget({
    Key? key,
    required this.currentlyProcessingFile,
    required this.currentProgress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (currentlyProcessingFile == '') return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
          title: Text(currentlyProcessingFile, style: theme.textTheme.bodyLarge),
          subtitle: currentProgress > 0 ? Text('$currentProgress%', style: theme.textTheme.bodyMedium) : null,
        ),
      ),
    );
  }
}

