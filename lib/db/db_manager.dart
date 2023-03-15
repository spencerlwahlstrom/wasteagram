import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'post_dto.dart';
import '../models/post.dart';


// maps Posts from fire store snapshot into list of Posts
List<Post> getPosts(AsyncSnapshot<QuerySnapshot> snapshot){
   return snapshot.data!.docs.map<Post>((record) {
      return Post(
          date: record['date'].toDate(),
          photo: record['photo'],
          items: record['items'],
          lat:  record['lat'],
          long: record['long']
      );
   },).toList();
}

// adds Post to firestore collection
void addPost(PostDTO dto) async {
    FirebaseFirestore.instance.collection('posts').add({
      'date': dto.date, 'photo': dto.photo, 'items': dto.items, 'lat': dto.lat, 'long': dto.long
    });
}

int getSum(AsyncSnapshot<QuerySnapshot> snapshot){
    int temp = 0;
    snapshot.data!.docs.forEach((document) {
        temp = (temp + document['items']) as int;
    },);
    return temp;
}

