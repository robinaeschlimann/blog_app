import '../data/blog.dart';
import '../repository/blog_repository.dart';

/// This class is a singleton and provides the blog data.
class BlogService {
  static final BlogService _blogService = BlogService._internal();

  factory BlogService() {
    return _blogService;
  }

  BlogService._internal();

  Future<List<Blog>> getBlogs() async {
    return await BlogRepository.instance.getBlogs();
  }
}