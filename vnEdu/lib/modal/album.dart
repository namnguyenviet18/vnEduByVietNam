import 'dart:convert';

List<Album> albumFromJson(String str) => List<Album>.from(json.decode(str).map((x) => Album.fromJson(x)));

class Album {
  final String imageUrl;
  
  Album({required this.imageUrl});
  
  factory Album.fromJson(Map<String, dynamic> json) =>
      Album(imageUrl: json['image_url']);
}