import 'package:flutter/material.dart';
import '../components/post_form.dart';

class NewPost extends StatelessWidget {
  final imageURL;
  const NewPost({super.key, required this.imageURL});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      title: const Text('New Post'),
      centerTitle:  true,
    ),
    body: Center(
      child:  Column(
              children: [
              Expanded(child: Image.network(imageURL)),
              Expanded(child: PostForm(imageURL: imageURL))
        ],),
    )
   );
  }
}