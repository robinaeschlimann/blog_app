import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Blog {
  const Blog({required this.title, required this.preview, required this.image, required this.liked});

  final String title;
  final String preview;
  final String image;
  final bool liked;
}

class BlogState extends ChangeNotifier {
  var blogs = <Blog>[
    const Blog(title: "Test-Blog", preview: "Lorem ipsum dolor sit amet...", image: "https://picsum.photos/100", liked: true),
    const Blog(title: "New Java version", preview: "Lorem ipsum dolor sit amet...", image: "https://picsum.photos/100", liked: true),
    const Blog(title: "How to Quarkus", preview: "Lorem ipsum dolor sit amet...", image: "https://picsum.photos/100", liked: false),
    const Blog(title: "Spring for Beginners", preview: "Lorem ipsum dolor sit amet...", image: "https://picsum.photos/100", liked: false),
    const Blog(title: "What is Flutter", preview: "Lorem ipsum dolor sit amet...", image: "https://picsum.photos/100", liked: false),
    const Blog(title: "Flutter Best Practices", preview: "Lorem ipsum dolor sit amet...", image: "https://picsum.photos/100", liked: true),
    const Blog(title: "How to Dart", preview: "Lorem ipsum dolor sit amet...", image: "https://picsum.photos/100", liked: true),
    const Blog(title: "How does AI work", preview: "Lorem ipsum dolor sit amet...", image: "https://picsum.photos/100", liked: true),
    const Blog(title: "Test-Blog-Title", preview: "Lorem ipsum dolor sit amet...", image: "https://picsum.photos/100", liked: false)];

    void addBlog(Blog blog) {
      blogs.add(blog);
      notifyListeners();
    }
}

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {

    var blogState = context.watch<BlogState>();

    return Stack(
      children: [
        ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: blogState.blogs.length,
          itemBuilder: (BuildContext context, int index) {
            var blog = blogState.blogs[index];
            return BlogCard( title: blog.title, preview: blog.preview,
              image: blog.image, liked: blog.liked);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          }
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            backgroundColor: const Color(0xFFC5264E),
            onPressed: () {
              blogState.addBlog(Blog(title: "New Blog ${blogState.blogs.length + 1}", preview: "Lorem ipsum dolor sit amet...", image: "https://picsum.photos/100", liked: false));
            },
            child: const Icon(Icons.add),
          ),
        )
    ]);
  }

}

class BlogCard extends StatelessWidget {
  const BlogCard({super.key, required this.title, required this.preview,
    required this.image, required this.liked});

  final String title;
  final String preview;
  final String image;
  final bool liked;

  @override
  Widget build(BuildContext context) {

    return Wrap(
      children: [
        Image(
            image: NetworkImage(image)
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 20)),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(preview),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Icon( liked ? Icons.favorite : Icons.favorite_border, color: const Color( 0xFFC5264E )),
              )
            ],
          ),
        ),
      ],
    );
  }
}