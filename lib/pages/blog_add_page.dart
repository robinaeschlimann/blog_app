import 'package:blog_app/data/blog.dart';
import 'package:blog_app/service/blog_service.dart';
import 'package:flutter/material.dart';

class BlogFormPage extends StatefulWidget {
  const BlogFormPage({super.key, this.blog});

  final Blog? blog;

  get getBlog => blog;

  @override
  _BlogFormPageState createState() => _BlogFormPageState( blog );
}

class _BlogFormPageState extends State<BlogFormPage> {

  _BlogFormPageState(this.blog);

  Blog? blog;

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    initValues();

    return Scaffold(
      appBar: AppBar(
        title: Text(blog == null ? "Add Blog" : "Edit Blog" )
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

                      var success = false;

                      if( blog != null )
                      {
                        // Edit blog
                        success = await BlogService.instance.editBlog(
                            Blog(
                                id: blog!.id,
                                title: title,
                                content: content,
                                publishedAt: blog!.publishedAt,
                                headerImageUrl: imageUrl,
                                headerImage: null,
                                isLikedByMe: blog!.isLikedByMe
                            )
                        );
                      }
                      else
                      {
                        // Add blog
                        success = await BlogService.instance.addBlog(
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
                      }

                      var scaffoldMessengerState = ScaffoldMessenger.of(context);

                      if( success )
                      {
                        scaffoldMessengerState.showSnackBar(
                            SnackBar(
                                content: Text(blog == null ? "Blog added" : "Blog edited"),
                                backgroundColor: Colors.green,
                                showCloseIcon: true
                            )
                        );

                        Navigator.of(context).pop();
                      }
                      else
                      {
                        scaffoldMessengerState.showSnackBar(
                            SnackBar(
                              content: Text(blog == null ? "Error while adding blog" : "Error while editing blog" ),
                              backgroundColor: Colors.red,
                              showCloseIcon: true
                            )
                        );
                      }
                    }
                  },
                  child: const Text("Save"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void initValues() {
    _titleController.value = blog == null ? TextEditingValue.empty : TextEditingValue(text: blog!.title);
    _contentController.value = blog == null ? TextEditingValue.empty : TextEditingValue(text: blog!.content);
    _imageUrlController.value = blog == null ? TextEditingValue.empty : TextEditingValue(text: blog!.headerImageUrl);
  }
}