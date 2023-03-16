import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import '../db/post_dto.dart';
import '../db/db_manager.dart';


class PostForm extends StatefulWidget{
  final imageURL;
  const PostForm({super.key, required this.imageURL});

  @override
  _PostFormState createState()  => _PostFormState();
}

class _PostFormState extends State<PostForm>{
  LocationData? locationData;
  var locationService = Location();
  final formKey = GlobalKey<FormState>();
  final PostDTO formField = PostDTO();
  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }
 void retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    void getDateTime() {
        formField.date = DateTime.now();
      }
    void getLocation() {
        formField.lat = locationData!.latitude!;
        formField.long = locationData!.longitude!;
    }

    void logEvent() async{
      await FirebaseAnalytics.instance.logEvent(
    name: "create_post",
    parameters: {
        "date": "${formField.date}",
        "items": "${formField.items}",
        "lat": "${formField.lat}",
        "long": "${formField.long}",
    },
);
    }
     return Form(
      key: formKey,
      child:  Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Semantics(
                  textField: true,
                  enabled: true,
                  label: 'Number of Wasted Items',
                  onTapHint: 'Number of Wasted Items',
                  child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: 'Number of Wasted Items'
                      ),
                      keyboardType: TextInputType.number,
                      
                      onSaved: (value) {
                        formField.items = int.parse(value!);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the number of items wasted';
                        } else {
                          return null;
                        }
                      },
                  ),
                ),
                Align( alignment: Alignment.bottomCenter,
                      child: Semantics(
                        button: true,
                        enabled: true,
                        label: 'upload button',
                        onTapHint: 'Upload an image',
                        child: GestureDetector(
                          onTap:(){
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                getDateTime();
                                getLocation();
                                formField.photo = widget.imageURL.toString();
                                // save to firestore
                                addPost(formField);
                               
                                Navigator.of(context).pop(); 
                              }
                          },
                          child: Container(height:75, width: MediaQuery.of(context).size.width, color: Colors.blue, child: const Icon(Icons.cloud_upload, color: Colors.white, size:  75,) ,)),
                      ),
                )
              ]),
      );
  }

}