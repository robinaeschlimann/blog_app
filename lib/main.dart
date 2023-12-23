import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'blog_page.dart';
import 'settings_page.dart';

void main() {
  runApp(const BlogApp());
}

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  @override
  Widget build(BuildContext context) {

      const primaryColor = Color(0xFFC5264E);
      const secondaryColor = Colors.white;

      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
            brightness: View.of(context).platformDispatcher.platformBrightness,
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: primaryColor,
            foregroundColor: secondaryColor,
          ),
          tabBarTheme: TabBarTheme(
            overlayColor: MaterialStateProperty.all(const Color(0xFFC5264E)),
            labelColor: secondaryColor,
            unselectedLabelColor: Colors.white70,

            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 4.0,
                color: secondaryColor,
              ),
            ),
          ),

        ),
        home: const MyHomePage(),
      );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Blog App"),
            actions: [
              IconButton(
                onPressed: () {

                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                  onPressed: () {

                  },
                  icon: const Icon(Icons.person)
              ),
            ],
          ),
          bottomNavigationBar: const NavigationBar(),
          body: TabBarView(
            children: [
              ChangeNotifierProvider(create: (context) => BlogState(), child: const BlogPage()),
              const SettingsPage(),
            ]
          ),
        )
      );
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).colorScheme.primary,
        child: const TabBar(

        tabs: [
          Tab(
            text: "Blogs",
            icon: Icon(Icons.abc_outlined),
          ),
          Tab(
            text: "Settings",
            icon: Icon(Icons.settings),
          ),
        ],
      )
    );
  }
}
