import 'package:flutter/material.dart';

class ModelDropdown extends StatelessWidget {
  final List<String> models;
  final String? selectedModel;
  final ValueChanged<String?>? onChanged;

  const ModelDropdown({
    Key? key,
    required this.models,
    required this.selectedModel,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonFormField<String>(
        initialValue: selectedModel,
        isExpanded: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[850]
              : Colors.grey[100],
        ),
        style: TextStyle(fontSize: 14, color: Theme.of(context).textTheme.bodyLarge?.color),
        icon: const Icon(Icons.expand_more),
        items: models
            .map((m) => DropdownMenuItem<String>(
                  value: m,
                  child: Text(m, style: const TextStyle(fontSize: 14)),
                ))
            .toList(),
        onChanged: onChanged,
        dropdownColor: Theme.of(context).cardColor,
      ),
    );
  }
}
