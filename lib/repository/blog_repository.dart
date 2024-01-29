import 'dart:convert';

import 'package:blog_app/data/blog.dart';
import 'package:blog_app/data/blog_db.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';


class BlogRepository {
  static BlogRepository instance = BlogRepository._privateConstructor();

  BlogRepository._privateConstructor();

  late final Isar isar;
  bool initialized = false;

  init() async {
    if( initialized ) {
      return;
    }

    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
        [BlogDBSchema],
        directory: dir.path);

    initialized = true;
  }

  Future<List<Blog>> getBlogs() async {
    await init();
    List<BlogDB> blogDBs = [];
    await isar.txn(() async {
      blogDBs.addAll(await isar.blogDBs.where().findAll() );
    });

    return blogDBs.map((blogDB) => _createBlog(blogDB)).toList();
  }

  Blog _createBlog(BlogDB blogDB) => Blog(id: blogDB.apiId, title: blogDB.title, content: blogDB.content, publishedAt: blogDB.publishedAt, headerImageUrl: blogDB.headerImageUrl, headerImage: blogDB.headerImage, isLikedByMe: blogDB.isLikedByMe);

  Future<void> saveBlogs(List<Blog> blogs) async {
    await init();

    List<BlogDB> blogDBs = await _createBlogDB(blogs);

    await isar.writeTxn(() async {
      await isar.blogDBs.clear();
      await isar.blogDBs.putAll(blogDBs);
    });
  }

  _getImageAsBase64(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    return base64Encode(bytes);
  }

  Future<List<BlogDB>> _createBlogDB ( List<Blog> blogs )
  {
    return Future.wait(blogs.map((blog) async => BlogDB()
      ..apiId = blog.id
      ..title = blog.title
      ..content = blog.content
      ..publishedAt = blog.publishedAt
      ..isLikedByMe = blog.isLikedByMe
      ..headerImageUrl = blog.headerImageUrl
      ..headerImage = await _getImageAsBase64(blog.headerImageUrl)
      ..creationDate = DateTime.now())
        .toList());
  }
}