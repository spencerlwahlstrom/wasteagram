import 'dart:ffi';

class Post {
  final DateTime date;
  final String photo;
  final int items;
  final double lat;
  final double long;
  Post({required this.date, required this.photo, required this.items, required this.lat, required this.long});
}