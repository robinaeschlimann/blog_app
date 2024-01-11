import 'package:blog_app/data/blog.dart';
import 'package:blog_app/service/blog_service.dart';
import 'package:blog_app/widget/blog/add_blog_button.dart';
import 'package:blog_app/widget/blog/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogState extends ChangeNotifier {
    var blogService = BlogService();

    Future<List<Blog>> get blogs async => await blogService.getBlogs();

    Future<bool> addBlog(Blog blog) async {
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
          future: blogState.blogs,
          builder: (context, snapshot) {
            if( snapshot.connectionState == ConnectionState.done )
            {
              return handleBlogsLoaded(snapshot);
            }
            else
            {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        ),
        const AddBlogButton()
    ]);
  }

  Widget handleBlogsLoaded(AsyncSnapshot<List<Blog>> snapshot) {
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
        return const Divider();
      }
    );
  }
}