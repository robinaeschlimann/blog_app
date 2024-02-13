import 'dart:convert';

import 'package:blog_app/data/blog.dart';
import 'package:blog_app/service/blog_service.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({super.key, required this.blog});

  final Blog blog;

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        blog.headerImage != null ?
          Image.memory(base64Decode(blog.headerImage!)) :
          Image(image: NetworkImage(blog.headerImageUrl)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(blog.title, style: const TextStyle(fontSize: 20)),
              Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(blog.content.length > 100 ? "${blog.content.substring(0, 100)}..." : blog.content )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Wrap(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            icon: blog.isLikedByMe ? const Icon( Icons.favorite ) : const Icon( Icons.favorite_border ),
                            color: const Color( 0xFFC5264E ),
                            constraints: const BoxConstraints(),
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(EdgeInsets.zero)
                            ),
                            onPressed: () => {}
                        ),
                        const Spacer(flex: 2),
                        IconButton(
                            icon: const Icon( Icons.edit ),
                            onPressed: () => {}
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            confirmDeletionDialog(context);
                            // todo: refresh blog list
                          },
                        ),
                      ],
                    ),
                  ]
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Future<void> confirmDeletionDialog( BuildContext context ) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Delete blog"),
          content: const Text("Are you sure you want to delete this blog?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {

                var success = await BlogService.instance.deleteBlog(blog.id!);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(success ? "Blog deleted" : "Error while deleting blog"),
                    backgroundColor: success ? Colors.green : Colors.red,
                    duration: const Duration(seconds: 2),
                  ),
                );

                Navigator.of(context).pop();
              },
              child: const Text("Delete"),
            ),
          ],
        )
    );
  }
}