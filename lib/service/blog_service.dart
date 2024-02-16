import 'dart:convert';

import 'package:blog_app/data/blog.dart';
import 'package:blog_app/repository/blog_repository.dart';
import 'package:blog_app/utils/logger.util.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

/// This class is a singleton and provides the blog data.
class BlogService {
  static final BlogService instance = BlogService.private();

  var logger = getLogger();

  BlogService.private();

  Future<List<Blog>> getBlogs() async {
    try {
      final response = await http.get(Uri.parse('https://cloud.appwrite.io/v1/databases/blog-db/collections/blogs/documents?limit=100'), headers: {
        'X-Appwrite-Project': '6568509f75ac404ff6ae',
        'X-Appwrite-Key': 'ac0f362d0cf82fe3d138195e142c0a87a88cee4e2c48821192fb307e1a1c74ee694246f90082b4441aa98a2edaddead28ed6d18cf08c4de0df90dcaeeb53d14f14fb9eeb2edec6708c9553434f1d8df8f8acbfbefd35cccb70f2ab0f9a334dfd979b6052f6e8b8610d57465cbe8d71a7f65e8d48aede789eef6b976b1fe9b2e2'
      });

      if(response.statusCode == 200) {
        var blogs = _getBlogsFromJson(response.body);
        BlogRepository.instance.saveBlogs(blogs);

        return blogs;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        logger.e("Failed to load blogs, status code: ${response.statusCode}, reason: ${response.reasonPhrase}");
        throw Exception('Failed to load blogs');
      }
    }
    catch (e) {
      // load blogs from local database
      return await BlogRepository.instance.getBlogs();
    }
  }

  List<Blog> _getBlogsFromJson( String json )
  {
    var blogs = jsonDecode(json)['documents'] as List;

    return blogs.map((blog) => Blog.fromJson(blog)).toList();
  }

  Future<bool> addBlog(Blog? blog) async {
    if( blog == null )
    {
      return false;
    }

    try {
      final response = await http.post(Uri.parse('https://cloud.appwrite.io/v1/databases/blog-db/collections/blogs/documents'), headers: {
        'X-Appwrite-Project': '6568509f75ac404ff6ae',
        'X-Appwrite-Key': 'ac0f362d0cf82fe3d138195e142c0a87a88cee4e2c48821192fb307e1a1c74ee694246f90082b4441aa98a2edaddead28ed6d18cf08c4de0df90dcaeeb53d14f14fb9eeb2edec6708c9553434f1d8df8f8acbfbefd35cccb70f2ab0f9a334dfd979b6052f6e8b8610d57465cbe8d71a7f65e8d48aede789eef6b976b1fe9b2e2',
        'Content-Type': 'application/json'
      }, body: jsonEncode({
        'documentId': const Uuid().v1(),
        'data': {
          'title': blog.title,
          'content': blog.content,
          'headerImageUrl': blog.headerImageUrl
        }
      }));

      if(response.statusCode == 201) {
        return true;
      } else {
        // If the server did not return a 201 Created response,
        // then throw an exception.
        logger.e("Failed to add blog, status code: ${response.statusCode}, reason: ${response.reasonPhrase}");
        throw Exception('Failed to add blog');
      }
    }
    catch (e) {
      return false;
    }
  }

  deleteBlog( String blogId ) async {
    try {
      final response = await http.delete(Uri.parse('https://cloud.appwrite.io/v1/databases/blog-db/collections/blogs/documents/$blogId'), headers: {
        'X-Appwrite-Project': '6568509f75ac404ff6ae',
        'X-Appwrite-Key': 'ac0f362d0cf82fe3d138195e142c0a87a88cee4e2c48821192fb307e1a1c74ee694246f90082b4441aa98a2edaddead28ed6d18cf08c4de0df90dcaeeb53d14f14fb9eeb2edec6708c9553434f1d8df8f8acbfbefd35cccb70f2ab0f9a334dfd979b6052f6e8b8610d57465cbe8d71a7f65e8d48aede789eef6b976b1fe9b2e2'
      });

      if(response.statusCode == 204) {
        return true;
      } else {
        // If the server did not return a 204 OK response,
        // then throw an exception.
        logger.e("Failed to delete blog, status code: ${response.statusCode}, reason: ${response.reasonPhrase}");
        throw Exception('Failed to delete blog');
      }
    }
    catch (e) {
      return false;
    }
  }

  editBlog( Blog blog ) async {
    try {
      final response = await http.patch(Uri.parse('https://cloud.appwrite.io/v1/databases/blog-db/collections/blogs/documents/${blog.id}'), headers: {
        'X-Appwrite-Project': '6568509f75ac404ff6ae',
        'X-Appwrite-Key': 'ac0f362d0cf82fe3d138195e142c0a87a88cee4e2c48821192fb307e1a1c74ee694246f90082b4441aa98a2edaddead28ed6d18cf08c4de0df90dcaeeb53d14f14fb9eeb2edec6708c9553434f1d8df8f8acbfbefd35cccb70f2ab0f9a334dfd979b6052f6e8b8610d57465cbe8d71a7f65e8d48aede789eef6b976b1fe9b2e2',
        'Content-Type': 'application/json'
      }, body: jsonEncode({
        'data': {
          'title': blog.title,
          'content': blog.content,
          'headerImageUrl': blog.headerImageUrl
        }
      }));

      if(response.statusCode == 200) {
        return true;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        logger.e("Failed to edit blog, status code: ${response.statusCode}, reason: ${response.reasonPhrase}");
        throw Exception('Failed to edit blog');
      }
    }
    catch (e) {
      return false;
    }
  }
}