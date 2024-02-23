import 'package:blog_app/pages/blog_add_page.dart';
import 'package:blog_app/states/blog_state.dart';
import 'package:flutter/material.dart';

class AddBlogButton extends StatelessWidget {
  const AddBlogButton({
    super.key,
    required this.blogState
  });

  final BlogState blogState;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BlogFormPage( blogState: blogState ),
              )
          );
        },
        icon: const Icon(Icons.add),
      );
  }
}