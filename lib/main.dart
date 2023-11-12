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
    return ChangeNotifierProvider(
      create: (context) => BlogState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: const Color(0xFFC5264E),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      )
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

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFC5264E),
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
                  icon: const Icon(Icons.person)),
            ],
          ),
          bottomNavigationBar: menu(),
          body: const TabBarView(
            children: [
              BlogPage(),
              SettingsPage(),
            ]
          ),
        )
      )
    );
  }
}

Widget menu() {
  return Container(
    color: Color(0xFFC5264E),
    child: const TabBar(
      indicatorColor: Colors.white,
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
    ),
  );
}
