
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/posts.dart';
import '../models/post.dart';
import '../screens/details.dart';

class PostList extends StatelessWidget{
  final Posts posts;
  const PostList({super.key, required this.posts});
  @override
  Widget build(BuildContext context) {
    return (ListView.builder(
      itemCount: posts.postsLength,
      itemBuilder: (context, index) {
            Post post = posts.posts[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=> Details(post: post)
              )
            );
              },
              child: (
                  ListTile(
                    title: Text(DateFormat.yMMMMEEEEd().format(post.date)),
                    trailing: Text('${post.items}', style: const TextStyle(fontSize: 25)),
                  )
              ),
            );
      }
    ) 
  );}
}