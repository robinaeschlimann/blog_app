import 'package:flutter/material.dart';

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    super.key,
    required this.title,
    required this.leadingIcon,
    this.trailing
  });

  final String title;
  final IconData leadingIcon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title),
        leading: Icon(leadingIcon),
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios)
    );
  }
}