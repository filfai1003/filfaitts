import 'package:flutter/material.dart';
import '../custom_widgets/custom_search_bar.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onAddPressed;

  const InputWidget({
    Key? key,
    required this.controller,
    required this.onSearchChanged,
    required this.onAddPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomSearchBar(
            controller: controller,
            onChanged: onSearchChanged,
          ),
        ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: onAddPressed,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}

