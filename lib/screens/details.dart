import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/post.dart';

class Details extends StatelessWidget{
  final Post post;
  const Details({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Waste Manager'),
          centerTitle:  true,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      Text(DateFormat.yMMMEd().format(post.date), style: Theme.of(context).textTheme.headline5),
                      Image.network(post.photo),
                      Text('${post.items} items', style: Theme.of(context).textTheme.headline4),
                      Text('location (${post.lat},  ${post.long})'),
                      
        ],),
      ),
    );
  }

}