import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/posts.dart';
import '../screens/new_post.dart';

class EmptyView extends StatelessWidget{
  EmptyView({super.key});
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
          title: const Text('Waste Manager'),
          centerTitle:  true,
        ),
        body: const Center(child: CircularProgressIndicator()),
        floatingActionButton: Semantics(
          button: true,
          enabled: true,
          label: 'Select an image',
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