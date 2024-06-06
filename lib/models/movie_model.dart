import 'dart:convert';

class MovieModel {
  final int id;
  final String title;
  final String imageUrl;
  final List<String> characters;

  MovieModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.characters,
  });

  Map<String, dynamic> toMap() {
    var map = {
      'title': title,
      'imageUrl': imageUrl,
      'characters': jsonEncode(characters),
    };

    return map;
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      characters: List<String>.from(
          jsonDecode(map['characters'])),
    );
  }
}
