import 'package:blog_app/pages/blog_add_page.dart';
import 'package:flutter/material.dart';

class AddBlogButton extends StatelessWidget {
  const AddBlogButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const BlogAddPage(),
              )
          );
        },
        icon: const Icon(Icons.add),
      );
  }
}