import 'dart:convert';

import 'package:blog_app/data/blog.dart';
import 'package:blog_app/data/storage_key.dart';
import 'package:blog_app/service/storage_manager.dart';
import 'package:blog_app/utils/logger.util.dart';

import 'package:http/http.dart' as http;

class BlogRepository {
  static BlogRepository instance = BlogRepository._privateConstructor();

  var logger = getLogger();
  BlogRepository._privateConstructor();

  Future<List<Blog>> getBlogs() async {

    try {
      final response = await http.get(Uri.parse('https://cloud.appwrite.io/v1/databases/blog-db/collections/blogs/documents?limit=100'), headers: {
        'X-Appwrite-Project': '6568509f75ac404ff6ae',
        'X-Appwrite-Key': 'ac0f362d0cf82fe3d138195e142c0a87a88cee4e2c48821192fb307e1a1c74ee694246f90082b4441aa98a2edaddead28ed6d18cf08c4de0df90dcaeeb53d14f14fb9eeb2edec6708c9553434f1d8df8f8acbfbefd35cccb70f2ab0f9a334dfd979b6052f6e8b8610d57465cbe8d71a7f65e8d48aede789eef6b976b1fe9b2e2'
      });

      if(response.statusCode == 200) {
        StorageManager.saveData(StorageKey.blogs.key, response.body);

        return getBlogsFromJson(response.body);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        logger.e("Failed to load blogs, status code: ${response.statusCode}, reason: ${response.reasonPhrase}");
        throw Exception('Failed to load blogs');
      }
    }
    catch (e) {
      // load blogs from local storage
      return await loadBlogsFromStorage();
    }
  }

  Future<List<Blog>> loadBlogsFromStorage() async {
    var blogs = await StorageManager.getData(StorageKey.blogs.key);
    return getBlogsFromJson(blogs as String);
  }

  List<Blog> getBlogsFromJson( String json )
  {
    var blogs = jsonDecode(json)['documents'] as List;

    return blogs.map((blog) => Blog.fromJson(blog)).toList();
  }

}