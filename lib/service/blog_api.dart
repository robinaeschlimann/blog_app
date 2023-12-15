import 'dart:convert';

import '../blog.dart';
import 'package:http/http.dart' as http;

class BlogApi {
  // Static instance + private Constructor for simple Singleton-approach
  static BlogApi instance = BlogApi._privateConstructor();
  BlogApi._privateConstructor();

  final _blogs = <Blog>[];

  Future<List<Blog>> getBlogs() async {

    final response = await http.get(Uri.parse('https://cloud.appwrite.io/v1/databases/blog-db/collections/blogs/documents?limit=100&orderField=\$id&orderType=ASC&offset=0&filters=[]'), headers: {
      'X-Appwrite-Project': '6568509f75ac404ff6ae',
      'X-Appwrite-Key': 'ac0f362d0cf82fe3d138195e142c0a87a88cee4e2c48821192fb307e1a1c74ee694246f90082b4441aa98a2edaddead28ed6d18cf08c4de0df90dcaeeb53d14f14fb9eeb2edec6708c9553434f1d8df8f8acbfbefd35cccb70f2ab0f9a334dfd979b6052f6e8b8610d57465cbe8d71a7f65e8d48aede789eef6b976b1fe9b2e2'
    });

    if(response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      var blogs = responseBody['documents'] as List;

      return blogs.map((blog) => Blog.fromJson(blog)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load blogs');
    }

    return _blogs;
  }

}