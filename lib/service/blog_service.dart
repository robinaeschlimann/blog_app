import '../blog.dart';
import 'blog_api.dart';

/// This class is a singleton and provides the blog data.
class BlogService {
  static final BlogService _blogService = BlogService._internal();

  factory BlogService() {
    return _blogService;
  }

  BlogService._internal();

  Future<List<Blog>> getBlogs() async {
    BlogApi blogApi = BlogApi.instance;

    return await blogApi.getBlogs();
  }
}