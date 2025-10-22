import 'package:flutter/material.dart';
import 'package:filfaitts/backend/trascription.dart';

import '../custom_widgets/listtile.dart';

class TranscriptionsList extends StatelessWidget {
  final List<Trascription> transcriptions;
  final void Function(Trascription) onTap;

  const TranscriptionsList({
    Key? key,
    required this.transcriptions,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (transcriptions.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(child: Text('No transcriptions', style: Theme.of(context).textTheme.bodyMedium)),
      );
    }

    return Column(
      children: transcriptions.map((t) {
        return AppListTile(
          title: t.title,
          subtitle: t.content,
          onTap: () => onTap(t),
        );
      }).toList(),
    );
  }
}

