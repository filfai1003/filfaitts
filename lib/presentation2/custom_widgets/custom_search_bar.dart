import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String hint;
  final IconData? icon;

  const CustomSearchBar({
    Key? key,
    required this.controller,
    this.onChanged,
    this.onSubmitted,
    this.hint = 'Search',
    this.icon = Icons.search,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyLarge ?? const TextStyle(fontSize: 14);
    final hintStyle = theme.inputDecorationTheme.hintStyle ?? textStyle.copyWith(color: theme.hintColor);

    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: (String value) {
        FocusScope.of(context).unfocus();
        if (onSubmitted != null) onSubmitted!(value);
      },
      style: textStyle,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: theme.iconTheme.color),
        filled: true,
        fillColor: theme.cardColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: hintStyle,
      ),
    );
  }
}

