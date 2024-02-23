import 'package:blog_app/pages/settings_page.dart';
import 'package:blog_app/service/theme_notifier.dart';
import 'package:blog_app/states/blog_state.dart';
import 'package:blog_app/utils/blog_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/blog_page.dart';
import 'widget/navigation_bar.dart';

Future<void> main() async {
  runApp(ChangeNotifierProvider(
      create: (_) => BrightnessNotifier.instance,
      child: const BlogApp()
  ));
}

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BrightnessNotifier> (
      builder: (context, brightnessNotifier, _) => ChangeNotifierProvider(
        create: (context) => BlogState(),
        child: MaterialApp(
          title: 'Blog App',
          debugShowCheckedModeBanner: false,
          theme: BlogTheme.getTheme(brightnessNotifier),
          home: const BlogAppPage(),
        ),
      )
    );
  }
}

class BlogAppPage extends StatelessWidget {
  const BlogAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: const BlogNavigationBar(),
          body: TabBarView(
            children: [
              const BlogPage(),
              ChangeNotifierProvider(create: (context) => SettingsState(), child: const SettingsPage()),
            ]
          ),
        )
      );
  }
}
