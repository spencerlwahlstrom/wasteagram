import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/posts.dart';
import 'post_list.dart';
import '../screens/new_post.dart';

class PostView extends StatelessWidget{
  final Posts posts;
  final int itemSum;
  PostView({super.key, required this.posts, required this.itemSum});
  File? image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    var fileName = '${DateTime.now()}.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    var url = await storageReference.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return(Scaffold(
        appBar: AppBar(
          title: Text('Waste Manager \ntotal wasted items: $itemSum'),
          centerTitle:  true,
        ),
        body: PostList(posts: posts),
        floatingActionButton: Semantics(
          button: true,
          enabled: true,
          label: 'select an image',
          onTapHint: 'Select an image',
          child: FloatingActionButton(
              onPressed: ((() async {
                var url = await getImage();
                Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=> NewPost(imageURL: url)
                )
              );
            })),
              child: const Icon(Icons.camera_alt)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    )
    );

  }

}