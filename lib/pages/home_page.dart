import 'package:flutter/material.dart' hide SearchBar;
import '../components/search_bar.dart';
import '../components/hero_card.dart';
import '../models/hero_model.dart';
import '../providers/database_provider.dart';
import '../theme.dart';
import 'detail_page.dart';
import 'category_page.dart';
import 'create_hero_page.dart';
import 'create_movie_page.dart'; // Import CreateMoviePage

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<HeroModel> _heroes = [];
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _loadHeroes();
  }

  void _loadHeroes() async {
    List<HeroModel> heroes = await DatabaseProvider().getHeroes();
    setState(() {
      _heroes = heroes;
    });
  }

  void _searchHeroes(String term) {
    setState(() {
      _searchTerm = term;
    });
  }

  void _reloadHeroes() {
    _loadHeroes();
  }

  void _showCreationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Crear nuevo'),
          content: Text('¿Qué te gustaría crear?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateHeroPage()),
                ).then((newHero) {
                  if (newHero != null) {
                    _reloadHeroes();
                  }
                });
              },
              child: Text('Héroe'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateMoviePage()),
                );
              },
              child: Text('Película'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<HeroModel> filteredHeroes = _heroes
        .where((hero) =>
            hero.name.toLowerCase().contains(_searchTerm.toLowerCase()))
        .toList();

    Map<String, List<HeroModel>> categorizedHeroes = {};
    for (var hero in filteredHeroes) {
      categorizedHeroes[hero.category] ??= [];
      categorizedHeroes[hero.category]!.add(hero);
    }

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text('Marvel Heroes'),
        backgroundColor: AppTheme.silverColor,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(child: SearchBar(onChanged: _searchHeroes)),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: _showCreationDialog,
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: categorizedHeroes.entries.map((entry) {
                String category = entry.key;
                List<HeroModel> heroes = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            category,
                            style: AppTheme.bold18px,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CategoryPage(category: category),
                              ),
                            ).then((_) => _reloadHeroes());
                          },
                          child: Text(
                            'Ver todo',
                            style: AppTheme.medium14px,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 250, // Ajusta esta altura según sea necesario
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: heroes.take(3).map((hero) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: HeroCard(
                              hero: hero,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPage(hero: hero),
                                  ),
                                ).then((updatedHero) {
                                  if (updatedHero != null) {
                                    _reloadHeroes();
                                  }
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
