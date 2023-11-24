import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          SettingsListTile(title: "Profile", leadingIcon: Icons.person),
          SettingsListTile(title: "Favorites", leadingIcon: Icons.favorite),
          SettingsListTile(title: "Language", leadingIcon: Icons.language),
          SettingsListTile ( title: "Setting XY", leadingIcon: Icons.settings ),
        ]
      ),
    );
  }

}

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    super.key,
    required this.title,
    required this.leadingIcon
  });

  final String title;
  final IconData leadingIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title),
        leading: Icon(leadingIcon),
        trailing: const Icon(Icons.arrow_forward_ios)
    );
  }
}