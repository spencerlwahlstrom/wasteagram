import 'post.dart';
class Posts{
  List<Post> posts;
  Posts({this.posts=const[]});
  int get postsLength => posts.length;
  bool get noPosts => posts.isEmpty;
}