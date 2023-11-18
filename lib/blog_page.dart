import 'dart:math';

import 'package:blog_app/service/blog_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blog.dart';

class BlogState extends ChangeNotifier {
    var blogService = BlogService();

    Future<List<Blog>> get blogs async => await blogService.getBlogs();

    Future<bool> addBlog(Blog blog) async {

      blogService.add(blog);
      notifyListeners();

      return true;
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
        FutureBuilder<List<Blog>>(
          initialData: const [],
          future: blogState.blogs,
          builder: (context, snapshot) {
            if( snapshot.connectionState == ConnectionState.done )
            {
              if( snapshot.hasError ) {
                return const Center(
                  child: Text("Error while loading blogs"),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  var blog = snapshot.data![index];
                  return BlogCard( blog: blog );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider( color: Colors.grey);
                }
              );

            }
            else
            {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFC5264E),
                ),
              );
            }
          }
        ),

        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            backgroundColor: const Color(0xFFC5264E),
            onPressed: () async {
              Random random = Random();
              var blog = Blog(title: "New Blog ${random.nextInt(100)}", preview: "Lorem ipsum dolor sit amet...", image: "https://picsum.photos/100", liked: false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: await blogState.addBlog(blog) ? const Text('Blog added') : const Text('Error while adding blog'))
              );
            },
            child: const Icon(Icons.add),
          ),
        )
    ]);
  }

}

class BlogCard extends StatelessWidget {
  const BlogCard({super.key, required this.blog});

  final Blog blog;

  @override
  Widget build(BuildContext context) {

    return Wrap(
      children: [
        Image(
            image: NetworkImage(blog.image)
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(blog.title, style: const TextStyle(fontSize: 20)),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(blog.preview),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Icon( blog.liked ? Icons.favorite : Icons.favorite_border, color: const Color( 0xFFC5264E )),
              )
            ],
          ),
        ),
      ],
    );
  }
}