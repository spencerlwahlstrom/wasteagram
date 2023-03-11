import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wastemanager/components/post_list.dart';

class ListScreen extends StatefulWidget{
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => ListScreenState();

}

class ListScreenState extends State<ListScreen>{
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          title: const Text('Waste Manager'),
          centerTitle:  true,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: 
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                 if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  return (
                    PostList(snapshot: snapshot)
                  );
                 } else {
                  return const Center(child: CircularProgressIndicator());
                 }
              }
              ,)
        
        )
    );
  }

}