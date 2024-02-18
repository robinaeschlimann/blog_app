import 'dart:convert';

import 'package:blog_app/data/blog.dart';
import 'package:blog_app/pages/blog_add_page.dart';
import 'package:blog_app/pages/blog_page.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({super.key, required this.blog, required this.blogState});

  final Blog blog;
  final BlogState blogState;

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
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: blog.isLikedByMe ? const Icon( Icons.favorite ) : const Icon( Icons.favorite_border ),
                    color: const Color( 0xFFC5264E ),
                    onPressed: () => {},
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon( Icons.edit ),
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlogFormPage( blog: blog, blogState: blogState, )))
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          confirmDeletionDialog(context, blogState);
                        },
                      ),
                    ],
                  ),

                ],
              ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Future<void> confirmDeletionDialog( BuildContext context, BlogState blogState ) {
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
                var success = await blogState.deleteBlog(blog.id!, context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(success ? "Blog deleted" : "Error while deleting blog"),
                    backgroundColor: success ? Colors.green : Colors.red,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: const Text("Delete"),
            ),
          ],
        )
    );
  }
}