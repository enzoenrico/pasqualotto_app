import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String code;
  final String ref;
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  const ListItem({
    Key? key,
    required this.code,
    required this.ref,
    required this.isChecked,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      title: Text(code, style: Theme.of(context).textTheme.titleLarge),
      subtitle: Text(ref, style: Theme.of(context).textTheme.titleMedium),
      trailing: Checkbox(
        value: isChecked,
        onChanged: onChanged,
      ),
    );
  }
}
