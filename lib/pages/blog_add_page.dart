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
              ElevatedButton(
                onPressed: () {

                },
                child: const Text("Add Blog"),
              )
            ],
          ),
        ),
      ),
    );
  }
}