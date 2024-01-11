import 'package:blog_app/service/storage_manager.dart';
import 'package:blog_app/service/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsState extends ChangeNotifier {
  var darkMode = false;

  Future<Switch> getDarkMode() async {
    bool darkMode = await StorageManager.getData('brightness') ?? false;

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
          const SettingsListTile(title: "Profile", leadingIcon: Icons.person, trailing: Icon(Icons.arrow_forward_ios)),
          SettingsListTile(title: "Dark Mode", leadingIcon: Icons.dark_mode, trailing: FutureBuilder(future: settingsState.getDarkMode(), builder: (context, snapshot) {
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
          },)),
          const SettingsListTile(title: "Favorites", leadingIcon: Icons.favorite, trailing: Icon(Icons.arrow_forward_ios)),
          const SettingsListTile(title: "Language", leadingIcon: Icons.language, trailing: Icon(Icons.arrow_forward_ios)),
          const SettingsListTile ( title: "Setting XY", leadingIcon: Icons.settings, trailing: Icon(Icons.arrow_forward_ios) ),
        ]
      ),
    );
  }

  onDarkmodeChange(bool value) {
    print( value );
  }

}



class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.trailing
  });

  final String title;
  final IconData leadingIcon;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title),
        leading: Icon(leadingIcon),
        trailing: trailing
    );
  }
}