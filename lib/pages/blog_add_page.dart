import 'package:blog_app/data/blog.dart';
import 'package:blog_app/service/blog_service.dart';
import 'package:flutter/material.dart';

class BlogAddPage extends StatefulWidget {
  const BlogAddPage({super.key});

  @override
  _BlogAddPageState createState() => _BlogAddPageState();
}

class _BlogAddPageState extends State<BlogAddPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Blog"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a title";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: "Content",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter content";
                  }
                  return null;
                },
                maxLines: 10,
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  labelText: "Image URL",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter an image URL";
                  }

                  if( !Uri.parse(value).isAbsolute )
                  {
                    return "Please enter a valid URL";
                  }

                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var title = _titleController.value.text;
                      var content = _contentController.value.text;
                      var imageUrl = _imageUrlController.value.text;

                      // Add blog
                      var success = await BlogService.instance.addBlog(
                          Blog(
                              id: null,
                              title: title,
                              content: content,
                              publishedAt: DateTime.now(),
                              headerImageUrl: imageUrl,
                              headerImage: null,
                              isLikedByMe: false
                          )
                      );

                      var scaffoldMessengerState = ScaffoldMessenger.of(context);

                      if( success )
                      {
                        scaffoldMessengerState.showSnackBar(
                            const SnackBar(
                                content: Text("Blog added"),
                                backgroundColor: Colors.green,
                                showCloseIcon: true
                            )
                        );

                        Navigator.of(context).pop();
                      }
                      else
                      {
                        scaffoldMessengerState.showSnackBar(
                            const SnackBar(
                              content: Text("Error while adding blog"),
                              backgroundColor: Colors.red,
                              showCloseIcon: true
                            )
                        );
                      }
                    }
                  },
                  child: const Text("Add Blog"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}