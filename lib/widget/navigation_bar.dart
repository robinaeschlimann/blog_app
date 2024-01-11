import 'package:flutter/material.dart';

class BlogNavigationBar extends StatelessWidget {
  const BlogNavigationBar({super.key,});

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