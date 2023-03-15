import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../components/post_list.dart';
import '../models/posts.dart';
import '../db/db_manager.dart';
import 'new_post.dart';

class ListScreen extends StatefulWidget{
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => ListScreenState();

}

class ListScreenState extends State<ListScreen>{
  int itemSum =0;
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
    return (Scaffold(
        appBar: AppBar(
          title: Text('Waste Manager \n total wasted items: $itemSum'),
          centerTitle:  true,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: 
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                 if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  Posts posts = Posts(posts: getPosts(snapshot));
                  itemSum = getSum(snapshot);
                  return (
                    PostList(posts: posts,)
                  );
                 } else {
                  return const Center(child: CircularProgressIndicator());
                 }
              }
              ,),
        floatingActionButton: FloatingActionButton(
            onPressed: ((() async {
              var url = await getImage();
              Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=> NewPost(imageURL: url)
              )
            );
          })),
            child: const Icon(Icons.camera_alt)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        )
    );
  }

}