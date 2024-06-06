import 'package:flutter/material.dart';
import '../models/hero_model.dart';
import '../models/movie_model.dart';
import '../providers/database_provider.dart';
import '../theme.dart';
import '../components/movie_card.dart';
import 'edit_hero_page.dart';
import 'edit_movie_page.dart'; // Import EditMoviePage

class DetailPage extends StatefulWidget {
  final HeroModel hero;

  const DetailPage({
    Key? key,
    required this.hero,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<MovieModel> _movies = [];

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  void _loadMovies() async {
    List<MovieModel> movies = await DatabaseProvider().getMovies();
    setState(() {
      _movies = movies
          .where((movie) => movie.characters.contains(widget.hero.name))
          .toList();
    });
  }

  Widget _buildDetailIcon(String label, String value, String assetPath) {
    return Column(
      children: [
        Image.asset(assetPath, width: 40, height: 40),
        SizedBox(height: 4),
        Text(value, style: AppTheme.medium16px),
        SizedBox(height: 2),
        Text(label, style: AppTheme.medium14px),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkColor,
      appBar: AppBar(
        title: Text(widget.hero.name, style: AppTheme.medium16px),
        backgroundColor: AppTheme.darkColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(widget.hero.imageUrl,
                    width: double.infinity, fit: BoxFit.cover),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.hero.name, style: AppTheme.medium10px),
                      Text(widget.hero.alias, style: AppTheme.heavy40px),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          _buildDetailIcon("", '${widget.hero.age} años',
                              'assets/icons/Age.png'),
                          SizedBox(width: 16),
                          _buildDetailIcon("", '${widget.hero.weight} kg',
                              'assets/icons/Weight.png'),
                          SizedBox(width: 16),
                          _buildDetailIcon("", '${widget.hero.height} m',
                              'assets/icons/Height.png'),
                          SizedBox(width: 16),
                          _buildDetailIcon("", widget.hero.earth,
                              'assets/icons/Universe.png'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Descripción:', style: AppTheme.bold18px),
                  Text(widget.hero.description, style: AppTheme.medium14px),
                  SizedBox(height: 16),
                  Text('Habilidades:', style: AppTheme.bold18px),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.hero.abilities.keys.map((ability) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            Text('$ability: ', style: AppTheme.medium14px),
                            Expanded(
                              child: Container(
                                height: 10,
                                decoration: BoxDecoration(
                                  color: AppTheme.greyColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                alignment: Alignment.centerLeft,
                                child: FractionallySizedBox(
                                  widthFactor:
                                      widget.hero.abilities[ability]! / 100.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text('${widget.hero.abilities[ability]}',
                                style: AppTheme.medium14px),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  Text('Películas:', style: AppTheme.bold18px),
                  SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _movies.map((movie) {
                        return MovieCard(
                          movie: movie,
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditMoviePage(movie: movie),
                              ),
                            );
                            if (result == true) {
                              // If a movie was deleted, reload the movies list
                              _loadMovies();
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditHeroPage(hero: widget.hero),
                            ),
                          ).then((updatedHero) {
                            if (updatedHero != null) {
                              Navigator.pop(context, updatedHero);
                            }
                          });
                        },
                        child: Text('Editar', style: AppTheme.medium16px),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirmar',
                                    style: AppTheme.medium16px),
                                content: Text(
                                    '¿Estás seguro de eliminar este héroe?',
                                    style: AppTheme.medium14px),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancelar',
                                        style: AppTheme.medium16px),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await DatabaseProvider()
                                          .deleteHero(widget.hero.id!);
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop(
                                          true); // Return true to indicate the hero was deleted
                                    },
                                    child: Text('Eliminar',
                                        style: AppTheme.medium16px),
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.red),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('Eliminar', style: AppTheme.medium16px),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
