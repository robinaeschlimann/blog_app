import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ListView(
        children: const [
          ListTile(
            title: Text("Profile"),
            leading: Icon(Icons.person),
            trailing: Icon(Icons.arrow_forward_ios)
          ),
          ListTile(
            title: Text("Favorites"),
            leading: Icon(Icons.favorite),
            trailing: Icon(Icons.arrow_forward_ios)
          ),
          ListTile(
              title: Text("Language"),
              leading: Icon(Icons.language),
              trailing: Icon(Icons.arrow_forward_ios)
          ),
          ListTile(
              title: Text("Setting X"),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.arrow_forward_ios)
          )
        ]
      ),
    );
  }

}