import 'package:flutter/material.dart';

class AppListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const AppListTile({super.key, required this.title, this.subtitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: Material(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          tileColor: theme.cardColor,
          title: Text(title, style: theme.textTheme.bodyLarge),
          subtitle: subtitle != null
              ? Text(subtitle!, maxLines: 1, overflow: TextOverflow.ellipsis, style: theme.textTheme.bodyMedium)
              : null,
          onTap: onTap,
        ),
      ),
    );
  }
}
