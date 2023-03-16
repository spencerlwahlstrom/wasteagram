import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../components/posts_view.dart';
import '../components/empty_view.dart';
import '../models/posts.dart';
import '../db/db_manager.dart';
import 'new_post.dart';

class ListScreen extends StatefulWidget{
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => ListScreenState();

}

class ListScreenState extends State<ListScreen>{
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
          stream: dbPosts.snapshots(),
          builder: 
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                 if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  Posts posts = Posts(posts: getPosts(snapshot));
                  int items = getSum(snapshot);
                  return (
                    PostView(posts: posts, itemSum: items)
                  );
                 } else {
                  return EmptyView();
                 }
              }
              ,);
  }

}