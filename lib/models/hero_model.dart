import 'dart:convert';

class HeroModel {
  final int? id;
  final String name;
  final String alias;
  final int age;
  final double weight;
  final double height;
  final String earth;
  final String category;
  final Map<String, int> abilities;
  final String description;
  final List<String> movies;
  final String imageUrl;

  HeroModel({
    this.id,
    required this.name,
    required this.alias,
    required this.age,
    required this.weight,
    required this.height,
    required this.earth,
    required this.category,
    required this.abilities,
    required this.description,
    required this.movies,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'alias': alias,
      'age': age,
      'weight': weight,
      'height': height,
      'earth': earth,
      'category': category,
      'abilities': jsonEncode(abilities),
      'description': description,
      'movies': jsonEncode(movies),
      'imageUrl': imageUrl,
    };
  }

  factory HeroModel.fromMap(Map<String, dynamic> map) {
    return HeroModel(
      id: map['id'],
      name: map['name'],
      alias: map['alias'],
      age: map['age'],
      weight: map['weight'],
      height: map['height'],
      earth: map['earth'],
      category: map['category'],
      abilities: Map<String, int>.from(jsonDecode(map['abilities'])),
      description: map['description'],
      movies: List<String>.from(jsonDecode(map['movies'])),
      imageUrl: map['imageUrl'],
    );
  }
}
