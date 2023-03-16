import 'package:test/test.dart';
import 'package:wastemanager/models/post.dart';

void main(){
  group('Posts', () {
    
    
test('Post model object initialized with values has appropriate property values', () {
    final date = DateTime.now();
    const url = 'TEST';
    const quantity =1;
    const latitude = 1.0;
    const longitude = 1.0;
    final Post post = Post(date: date, photo: url, items: quantity, lat: latitude, long: longitude);
    expect(post.date, date);
  }
  );

test('Post model object initialized with values, has appropriate property values', () {
    final date = DateTime.now();
    const url = 'TEST';
    const quantity =1;
    const latitude = 1.0;
    const longitude = 1.0;
    final Post post = Post(date: date, photo: url, items: quantity, lat: latitude, long: longitude);
    expect(post.photo, url);
  }
  );

  });
  
test('Post model object initialized with values has appropriate property values', () {
    final date = DateTime.now();
    const url = 'TEST';
    const quantity =1;
    const latitude = 1.0;
    const longitude = 1.0;
    final Post post = Post(date: date, photo: url, items: quantity, lat: latitude, long: longitude);
    expect(post.items, quantity);
  }
  );


}