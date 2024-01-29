import 'dart:convert';

import 'package:blog_app/data/blog.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({super.key, required this.blog});

  final Blog blog;

  @override
  Widget build(BuildContext context) {

    return Wrap(
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
                child: Icon( blog.isLikedByMe ? Icons.favorite : Icons.favorite_border, color: const Color( 0xFFC5264E )),
              )
            ],
          ),
        ),
      ],
    );
  }
}