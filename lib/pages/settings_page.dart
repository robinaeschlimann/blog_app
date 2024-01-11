import 'package:blog_app/service/storage_manager.dart';
import 'package:blog_app/service/theme_notifier.dart';
import 'package:blog_app/widget/settings/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsState extends ChangeNotifier {
  Future<Switch> getDarkMode() async {
    bool darkMode = BrightnessNotifier.instance.brightness == Brightness.dark;

    return Switch(value: darkMode, onChanged: (val) => setDarkMode(val));
  }

  Future<void> setDarkMode(bool value) async {
    BrightnessNotifier.instance.setBrightness(value);
    notifyListeners();

    StorageManager.saveData('brightness', value);
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    var settingsState = context.watch<SettingsState>();

    return Scaffold(
      body: ListView(
        children: [
          const SettingsListTile(title: "Profile", leadingIcon: Icons.person),
          const SettingsListTile(title: "Favorites", leadingIcon: Icons.favorite),
          SettingsListTile(title: "Dark Mode", leadingIcon: Icons.dark_mode,
            trailing: SizedBox(
              width: 50,
              child: FutureBuilder(
                future: settingsState.getDarkMode(),
                builder: (context, snapshot) {
                  return buildDarkModeSwitch(snapshot);
                }
              )
            )
          )
        ],
      ),
    );
  }

  Widget buildDarkModeSwitch(AsyncSnapshot<Switch> snapshot) {
    if( snapshot.connectionState == ConnectionState.done )
    {
      if( snapshot.hasError ) {
        return const Center(
          child: Text("Error while loading dark mode"),
        );
      }

      return snapshot.data as Switch;
    }
    else
    {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}