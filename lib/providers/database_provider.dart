import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/hero_model.dart';
import '../models/movie_model.dart';
import 'dart:convert';

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();

  factory DatabaseProvider() => _instance;
  static Database? _database;

  DatabaseProvider._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'heroes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onOpen: (db) async {
        await _checkAndInsertInitialData(db);
      },
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE heroes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        alias TEXT,
        age INTEGER,
        weight REAL,
        height REAL,
        earth TEXT,
        category TEXT,
        abilities TEXT,
        description TEXT,
        movies TEXT,
        imageUrl TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE movies (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        imageUrl TEXT,
        characters TEXT
      )
    ''');
  }

  Future _checkAndInsertInitialData(Database db) async {
    var heroesResult = await db.query('heroes');
    if (heroesResult.isEmpty) {
      List<HeroModel> initialHeroes = [
        HeroModel(
          name: 'Peter Parker',
          alias: 'Hombre Araña',
          age: 30,
          weight: 78,
          height: 1.80,
          earth: 'Tierra 616',
          category: 'Héroes',
          abilities: {
            'Fuerza': 80,
            'Inteligencia': 90,
            'Agilidad': 95,
            'Resistencia': 85,
            'Velocidad': 75,
          },
          description:
              'El Hombre Araña es un superhéroe ficticio creado por el escritor Stan Lee y el dibujante Steve Ditko.',
          movies: ['Civil War', 'Endgame', 'Homecoming'],
          imageUrl:
              'https://m.media-amazon.com/images/I/817eK5V+T5L._AC_SL1000_.jpg',
        ),
        HeroModel(
          name: 'Tony Stark',
          alias: 'Hombre de Hierro',
          age: 45,
          weight: 85,
          height: 1.85,
          earth: 'Tierra 616',
          category: 'Héroes',
          abilities: {
            'Fuerza': 70,
            'Inteligencia': 100,
            'Agilidad': 60,
            'Resistencia': 70,
            'Velocidad': 60,
          },
          description:
              'Tony Stark es un industrial multimillonario y el superhéroe Iron Man.',
          movies: ['Iron Man', 'Endgame', 'Infinity War'],
          imageUrl:
              'https://m.media-amazon.com/images/I/817eK5V+T5L._AC_SL1000_.jpg',
        ),
        HeroModel(
          name: 'Bruce Banner',
          alias: 'Hulk',
          age: 40,
          weight: 400,
          height: 2.80,
          earth: 'Tierra 616',
          category: 'Héroes',
          abilities: {
            'Fuerza': 100,
            'Inteligencia': 80,
            'Agilidad': 50,
            'Resistencia': 100,
            'Velocidad': 40,
          },
          description:
              'Hulk es un superhéroe ficticio que aparece en los cómics estadounidenses publicados por Marvel Comics.',
          movies: ['Avengers', 'Endgame', 'Infinity War'],
          imageUrl:
              'https://m.media-amazon.com/images/I/817eK5V+T5L._AC_SL1000_.jpg',
        ),
        HeroModel(
          name: 'Steve Rogers',
          alias: 'Capitán América',
          age: 100,
          weight: 100,
          height: 1.90,
          earth: 'Tierra 616',
          category: 'Héroes',
          abilities: {
            'Fuerza': 80,
            'Inteligencia': 70,
            'Agilidad': 80,
            'Resistencia': 90,
            'Velocidad': 70,
          },
          description:
              'El Capitán América es un superhéroe ficticio que aparece en los cómics estadounidenses publicados por Marvel Comics.',
          movies: ['Avengers', 'Endgame', 'Infinity War'],
          imageUrl:
              'https://m.media-amazon.com/images/I/817eK5V+T5L._AC_SL1000_.jpg',
        ),
        HeroModel(
          name: 'Thanos',
          alias: 'Thanos',
          age: 1000,
          weight: 300,
          height: 2.50,
          earth: 'Tierra 616',
          category: 'Villanos',
          abilities: {
            'Fuerza': 100,
            'Inteligencia': 90,
            'Agilidad': 60,
            'Resistencia': 100,
            'Velocidad': 50,
          },
          description:
              'Thanos es un supervillano ficticio que aparece en los cómics estadounidenses publicados por Marvel Comics.',
          movies: ['Avengers', 'Infinity War', 'Endgame'],
          imageUrl:
              'https://m.media-amazon.com/images/I/817eK5V+T5L._AC_SL1000_.jpg',
        ),
        HeroModel(
          name: 'Loki',
          alias: 'Loki',
          age: 1000,
          weight: 75,
          height: 1.85,
          earth: 'Tierra 616',
          category: 'Anti-héroes',
          abilities: {
            'Fuerza': 70,
            'Inteligencia': 95,
            'Agilidad': 75,
            'Resistencia': 80,
            'Velocidad': 70,
          },
          description:
              'Loki es un personaje ficticio que aparece en los cómics estadounidenses publicados por Marvel Comics.',
          movies: ['Avengers', 'Thor', 'Ragnarok'],
          imageUrl:
              'https://m.media-amazon.com/images/I/817eK5V+T5L._AC_SL1000_.jpg',
        ),
        HeroModel(
          name: 'Drax',
          alias: 'Drax el Destructor',
          age: 35,
          weight: 85,
          height: 1.85,
          earth: 'Tierra 616',
          category: 'Alienígenas',
          abilities: {
            'Fuerza': 85,
            'Inteligencia': 50,
            'Agilidad': 70,
            'Resistencia': 85,
            'Velocidad': 60,
          },
          description:
              'Drax el Destructor es un personaje ficticio que aparece en los cómics estadounidenses publicados por Marvel Comics.',
          movies: ['Guardians of the Galaxy', 'Infinity War', 'Endgame'],
          imageUrl:
              'https://m.media-amazon.com/images/I/817eK5V+T5L._AC_SL1000_.jpg',
        ),
      ];

      for (var hero in initialHeroes) {
        await db.insert('heroes', hero.toMap());
      }
    }

    var moviesResult = await db.query('movies');
    if (moviesResult.isEmpty) {
      List<MovieModel> initialMovies = [
        MovieModel(
          id: 1,
          title: 'Avengers',
          imageUrl:
              'https://m.media-amazon.com/images/I/61nIxrLL8QL._AC_SL1000_.jpg',
          characters: ['Iron Man', 'Thor', 'Hulk', 'Captain America'],
        ),
        MovieModel(
          id: 2,
          title: 'Guardians of the Galaxy',
          imageUrl:
              'https://m.media-amazon.com/images/I/61nIxrLL8QL._AC_SL1000_.jpg',
          characters: ['Star-Lord', 'Gamora', 'Drax', 'Rocket', 'Groot'],
        ),
        MovieModel(
          id: 3,
          title: 'Spider-Man: Homecoming',
          imageUrl:
              'https://m.media-amazon.com/images/I/61nIxrLL8QL._AC_SL1000_.jpg',
          characters: ['Spider-Man', 'Iron Man', 'Vulture'],
        ),
      ];

      for (var movie in initialMovies) {
      //  await db.insert('movies', movie.toMap());
      }
    }
  }

  Future<int> insertHero(HeroModel hero) async {
    Database db = await database;
    return await db.insert('heroes', hero.toMap());
  }

  Future<List<HeroModel>> getHeroes() async {
    Database db = await database;
    var heroes = await db.query('heroes');
    return heroes.isNotEmpty
        ? heroes.map((hero) => HeroModel.fromMap(hero)).toList()
        : [];
  }

  Future<int> updateHero(HeroModel hero) async {
    Database db = await database;
    return await db
        .update('heroes', hero.toMap(), where: 'id = ?', whereArgs: [hero.id]);
  }

  Future<int> deleteHero(int id) async {
    Database db = await database;
    return await db.delete('heroes', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertMovie(MovieModel movie) async {
    Database db = await database;
    return await db.insert('movies', movie.toMap());
  }

  Future<List<MovieModel>> getMovies() async {
    Database db = await database;
    var movies = await db.query('movies');
    return movies.isNotEmpty
        ? movies.map((movie) => MovieModel.fromMap(movie)).toList()
        : [];
  }

  Future<int> updateMovie(MovieModel movie) async {
    Database db = await database;
    return await db.update('movies', movie.toMap(),
        where: 'id = ?', whereArgs: [movie.id]);
  }

  Future<int> deleteMovie(int id) async {
    Database db = await database;
    return await db.delete('movies', where: 'id = ?', whereArgs: [id]);
  }
}
