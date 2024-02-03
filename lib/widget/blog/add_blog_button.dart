import 'package:blog_app/pages/blog_add_page.dart';
import 'package:flutter/material.dart';

class AddBlogButton extends StatelessWidget {
  const AddBlogButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      right: 16,
      child: FloatingActionButton(
        backgroundColor: const Color(0xFFC5264E),
        onPressed: () async {
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const BlogAddPage(),
              )
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}