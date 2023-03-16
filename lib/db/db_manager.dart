import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'post_dto.dart';
import '../models/post.dart';

final db = FirebaseFirestore.instance;
final dbPosts = db.collection('posts');
// maps Posts from fire store snapshot into list of Posts
List<Post> getPosts(AsyncSnapshot<QuerySnapshot> snapshot){
   return snapshot.data!.docs.map<Post>((record) {
      return Post(
          date: record['date'].toDate(),
          photo: record['imageURL'],
          items: record['quantity'],
          lat:  record['latitude'],
          long: record['longitude']
      );
   },).toList();
}

// adds Post to firestore collection
void addPost(PostDTO dto) async {
    db.collection('posts').add({
      'date': dto.date, 'imageURL': dto.photo, 'quantity': dto.items, 'latitude': dto.lat, 'longitude': dto.long
    });
}

int getSum(AsyncSnapshot<QuerySnapshot> snapshot){
    int temp = 0;
    var documents = snapshot.data!.docs;
    for (var document in documents) {
        temp = (temp + document['quantity']) as int;
    }
    return temp;
  }

