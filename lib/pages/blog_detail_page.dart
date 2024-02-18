import 'dart:convert';

import 'package:blog_app/data/blog.dart';
import 'package:flutter/material.dart';

class BlogDetailPage extends StatelessWidget {
  final Blog blog;

  const BlogDetailPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            blog.headerImage != null ?
              Image.memory(base64Decode(blog.headerImage!)) :
              Image.network(blog.headerImageUrl),
            const SizedBox(height: 10),
            Text(blog.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(blog.content),
          ],
        ),
      ),
    );
  }
}