import 'package:blog_app/data/blog.dart';
import 'package:blog_app/pages/blog_detail_page.dart';
import 'package:blog_app/states/blog_state.dart';
import 'package:blog_app/widget/blog/add_blog_button.dart';
import 'package:blog_app/widget/blog/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {

    var blogState = context.watch<BlogState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Blogs"),
        actions: const [
          AddBlogButton()
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder<List<Blog>>(
            future: blogState.blogs,
            builder: (context, snapshot) {
              if( snapshot.connectionState == ConnectionState.done )
              {
                return handleBlogsLoaded(snapshot, blogState);
              }
              else
              {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          ),
        ]
      )
    );
  }

  Widget handleBlogsLoaded(AsyncSnapshot<List<Blog>> snapshot, BlogState blogState ) {
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
        return GestureDetector(
          child: BlogCard( blog: blog ),
          onTap: () {
            Navigator.of(context).push(
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => BlogDetailPage(blog: blog),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      var begin = const Offset(1.0, 0.0);
                      var end = Offset.zero;
                      var curve = Curves.ease;
                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    }
                )
            );
          }
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      }
    );
  }
}