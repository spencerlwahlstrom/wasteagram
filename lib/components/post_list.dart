import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post.dart';

class PostList extends StatelessWidget{
  final AsyncSnapshot<QuerySnapshot> snapshot;
  const PostList({super.key, required this.snapshot});
  @override
  Widget build(BuildContext context) {
    return (ListView.builder(
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
            var snap = snapshot.data!.docs[index];
            Post post = Post(date: snap['date'], photo: snap['photo'], items: snap['item_count'], location: snap['location'] );
            return (
                ListTile(
                  title: Text(post.date),
                  subtitle: Text(post.items.toString()),
                )
            );
      }
    ) 
  );}
}