import 'post.dart';
class Posts{
  final List<Post> posts;
  Posts({this.posts=const[]});
  int get postsLength => posts.length;
  bool get noPosts => posts.isEmpty;
}