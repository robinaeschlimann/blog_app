import '../blog.dart';
import 'blog_api.dart';

/// This class is a singleton and provides the blog data.
class BlogService {
  static final BlogService _blogService = BlogService._internal();

  List<Blog> blogs = [];

  factory BlogService() {
    return _blogService;
  }

  BlogService._internal();

  Future<List<Blog>> getBlogs() async {
    // if( this.blogs.isEmpty ){
    //   this.blogs.addAll([
    //     const Blog(title: "Test-Blog", preview: "Lorem ipsum dolor sit amet...", image: "https://picsum.photos/100", liked: true),
    //     const Blog(title: "New Java version", preview: "Lorem ipsum dolor sit amet...", image: "https://picsum.photos/100", liked: true),
    //     const Blog(title: "How to Quarkus", preview: "Lorem ipsum dolor sit amet...", image: "https://picsum.photos/100", liked: false),
    //     const Blog(title: "Spring for Beginners", preview: "Lorem ipsum dolor sit amet...", image: "https://picsum.photos/100", liked: false),
    //     const Blog(title: "What is Flutter", preview: "Lorem ipsum dolor sit amet...", image: "https://picsum.photos/100", liked: false),
    //     const Blog(title: "Flutter Best Practices", preview: "Lorem ipsum dolor sit amet...", image: "https://picsum.photos/100", liked: true),
    //     const Blog(title: "How to Dart", preview: "Lorem ipsum dolor sit amet...", image: "https://picsum.photos/100", liked: true),
    //     const Blog(title: "How does AI work", preview: "Lorem ipsum dolor sit amet...", image: "https://picsum.photos/100", liked: true),
    //     const Blog(title: "Test-Blog-Title", preview: "Lorem ipsum dolor sit amet...", image: "https://picsum.photos/100", liked: false)]);
    // }

    var blogs = <Blog>[];

    await Future.delayed(const Duration(seconds: 2), () {
      blogs = this.blogs;
    });

    return blogs;
  }

  Future<List<Blog>> getBlogsApi() async {
    BlogApi blogApi = BlogApi.instance;

    var blogs = <Blog>[];

    await blogApi.getBlogs().then((value) {
      blogs = value;
    });

    return blogs;
  }

  void add(Blog blog) async {
    await Future.delayed(const Duration(seconds: 2), () {
      blogs.add(blog);
    });
  }
}