import 'package:flutter/material.dart';

class AddBlogButton extends StatelessWidget {
  const AddBlogButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      right: 16,
      child: FloatingActionButton(
        backgroundColor: const Color(0xFFC5264E),
        onPressed: () async {

        },
        child: const Icon(Icons.add),
      ),
    );
  }
}