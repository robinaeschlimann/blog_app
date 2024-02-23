import 'package:blog_app/data/blog.dart';
import 'package:blog_app/service/blog_service.dart';
import 'package:flutter/material.dart';

class BlogState extends ChangeNotifier {
  var blogService = BlogService.instance;

  Future<List<Blog>> get blogs async => await blogService.getBlogs();

  addBlog( Blog blog )
  {
    var success = blogService.addBlog(blog);
    notifyListeners();

    return success;
  }

  editBlog( Blog blog ) async
  {
    var success = await blogService.editBlog(blog);
    notifyListeners();

    return success;
  }

  deleteBlog( String blogId, BuildContext context ) async {
    var success = await blogService.deleteBlog(blogId);

    Navigator.of(context).pop();

    notifyListeners();

    return success;
  }
}