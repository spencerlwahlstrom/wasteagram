import 'dart:ffi';

class Post {
  final String date;
  final String photo;
  final int items;
  final String location;
  Post({required this.date, required this.photo, required this.items, required this.location});
}